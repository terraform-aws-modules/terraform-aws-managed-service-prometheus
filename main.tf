data "aws_caller_identity" "current" {
  count = local.create_resource_policy ? 1 : 0
}

data "aws_partition" "current" {
  count = local.create_resource_policy ? 1 : 0
}

data "aws_region" "current" {
  count = local.create_resource_policy ? 1 : 0

  region = var.region
}

locals {
  partition  = try(data.aws_partition.current[0].partition, "aws")
  account_id = try(data.aws_caller_identity.current[0].account_id, "")
  region     = try(data.aws_region.current[0].region, "")

  workspace_id = var.create && var.create_workspace ? aws_prometheus_workspace.this[0].id : var.workspace_id

  # Since we are accepting externally created workspaces, we need to re-construct the ARN for the policy
  workspace_arn = var.create && var.create_workspace ? aws_prometheus_workspace.this[0].arn : "arn:${local.partition}:aps:${local.region}:${local.account_id}:workspace/${var.workspace_id}"
}

################################################################################
# Workspace
################################################################################

resource "aws_prometheus_workspace" "this" {
  count = var.create && var.create_workspace ? 1 : 0

  region = var.region

  alias       = var.workspace_alias
  kms_key_arn = var.kms_key_arn

  dynamic "logging_configuration" {
    for_each = var.logging_configuration != null ? [var.logging_configuration] : []

    content {
      log_group_arn = logging_configuration.value.create_log_group ? "${aws_cloudwatch_log_group.this[0].arn}:*" : logging_configuration.value.log_group_arn
    }
  }

  tags = var.tags
}

################################################################################
# Workspace Configuration
################################################################################

resource "aws_prometheus_workspace_configuration" "this" {
  count = var.create && var.create_workspace && var.limits_per_label_set != null ? 1 : 0

  region = var.region

  retention_period_in_days = var.retention_period_in_days
  workspace_id             = local.workspace_id

  dynamic "limits_per_label_set" {
    for_each = var.limits_per_label_set != null ? var.limits_per_label_set : []

    content {
      label_set = limits_per_label_set.value.label_set

      dynamic "limits" {
        for_each = [limits_per_label_set.value.limits]

        content {
          max_series = limits.value.max_series
        }
      }
    }
  }
}

################################################################################
# Resource Policy
################################################################################

data "aws_service_principal" "grafana" {
  count = local.create_resource_policy ? 1 : 0

  region       = var.region
  service_name = "grafana"
}

locals {
  create_resource_policy = var.create && var.create_workspace && var.create_resource_policy
}

data "aws_iam_policy_document" "resource_policy" {
  count = local.create_resource_policy ? 1 : 0

  dynamic "statement" {
    # Default permissions if custom permissions are not provided
    for_each = var.resource_policy_statements == null ? [1] : []

    content {
      sid = "DefaultAccountReadWrite"
      principals {
        type        = "AWS"
        identifiers = [data.aws_caller_identity.current[0].account_id]
      }
      actions = [
        "aps:RemoteWrite",
        "aps:QueryMetrics",
        "aps:GetSeries",
        "aps:GetLabels",
        "aps:GetMetricMetadata",
      ]
      resources = [local.workspace_arn]
    }
  }

  dynamic "statement" {
    # Default permissions if custom permissions are not provided
    for_each = var.resource_policy_statements == null ? [1] : []

    content {
      sid = "DefaultGrafanaRead"
      principals {
        type        = "Service"
        identifiers = [data.aws_service_principal.grafana[0].name]
      }
      actions = [
        "aps:QueryMetrics",
        "aps:GetSeries",
        "aps:GetLabels",
        "aps:GetMetricMetadata",
      ]
      resources = [local.workspace_arn]
    }
  }

  dynamic "statement" {
    for_each = var.resource_policy_statements != null ? var.resource_policy_statements : {}

    content {
      sid           = try(coalesce(statement.value.sid, statement.key))
      actions       = statement.value.actions
      not_actions   = statement.value.not_actions
      effect        = statement.value.effect
      resources     = coalescelist(statement.value.resources, [local.workspace_arn])
      not_resources = statement.value.not_resources

      dynamic "principals" {
        for_each = statement.value.principals != null ? statement.value.principals : []

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = statement.value.not_principals != null ? statement.value.not_principals : []

        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = statement.value.condition != null ? statement.value.condition : []

        content {
          test     = condition.value.test
          values   = condition.value.values
          variable = condition.value.variable
        }
      }
    }
  }
}

resource "aws_prometheus_resource_policy" "this" {
  count = local.create_resource_policy ? 1 : 0

  region = var.region

  workspace_id    = local.workspace_id
  policy_document = data.aws_iam_policy_document.resource_policy[0].json
}

################################################################################
# Cloudwatch Log Group
################################################################################

locals {
  log_group_name = try(coalesce(var.cloudwatch_log_group_name, "/aws/prometheus/${var.workspace_alias}"), "")
}

resource "aws_cloudwatch_log_group" "this" {
  count = var.create && var.create_workspace && try(coalesce(var.logging_configuration.create_log_group), true) ? 1 : 0

  region = var.region

  name              = var.cloudwatch_log_group_use_name_prefix ? null : local.log_group_name
  name_prefix       = var.cloudwatch_log_group_use_name_prefix ? "${local.log_group_name}-" : null
  log_group_class   = var.cloudwatch_log_group_class
  retention_in_days = var.cloudwatch_log_group_retention_in_days
  kms_key_id        = var.cloudwatch_log_group_kms_key_id

  tags = var.tags
}

################################################################################
# Alert Manager Definition
################################################################################

resource "aws_prometheus_alert_manager_definition" "this" {
  count = var.create && var.create_alert_manager ? 1 : 0

  region = var.region

  workspace_id = local.workspace_id
  definition   = var.alert_manager_definition
}

################################################################################
# Rule Group Namespace
################################################################################

resource "aws_prometheus_rule_group_namespace" "this" {
  for_each = var.create && var.rule_group_namespaces != null ? var.rule_group_namespaces : {}

  region = var.region

  name         = each.value.name
  workspace_id = local.workspace_id
  data         = each.value.data
}
