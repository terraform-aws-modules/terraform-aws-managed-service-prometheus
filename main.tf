data "aws_caller_identity" "current" {}

locals {
  workspace_id = var.create && var.create_workspace ? aws_prometheus_workspace.this[0].id : var.workspace_id

  # Placeholders in the policy document to be replaced with the actual values
  policy_placeholders = {
    "_PROMETHEUS_ARN_" = try(aws_prometheus_workspace.this[0].arn, null),
    "_AWS_ACCOUNT_ID_" = try(data.aws_caller_identity.current.account_id, null)
  }

  policy = var.create && var.create_workspace && var.attach_policy ? replace(
    replace(
      data.aws_iam_policy_document.combined[0].json,
      "_PROMETHEUS_ARN_", local.policy_placeholders["_PROMETHEUS_ARN_"]
    ),
    "_AWS_ACCOUNT_ID_", local.policy_placeholders["_AWS_ACCOUNT_ID_"]
  ) : ""
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
  count = var.create && var.create_workspace ? 1 : 0

  region = var.region

  retention_period_in_days = var.retention_period_in_days
  workspace_id             = local.workspace_id

  dynamic "limits_per_label_set" {
    for_each = var.limits_per_label_set != null ? var.limits_per_label_set : []

    content {
      label_set = limits_per_label_set.value.label_set

      dynamic "limits" {
        for_each = limits_per_label_set.value.limits

        content {
          max_series = limits.value.max_series
        }
      }
    }
  }
}

data "aws_iam_policy_document" "combined" {
  count = var.create && var.create_workspace && var.attach_policy ? 1 : 0

  source_policy_documents = compact([
    var.attach_policy ? var.policy : ""
  ])
}

resource "aws_prometheus_resource_policy" "this" {
  count = var.create && var.create_workspace && var.attach_policy ? 1 : 0

  region = var.region

  workspace_id    = local.workspace_id
  policy_document = local.policy
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
