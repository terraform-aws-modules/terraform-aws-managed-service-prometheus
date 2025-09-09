locals {
  workspace_id = var.create && var.create_workspace ? aws_prometheus_workspace.this[0].id : var.workspace_id
}

################################################################################
# Workspace
################################################################################

resource "aws_prometheus_workspace" "this" {
  count = var.create && var.create_workspace ? 1 : 0

  alias       = var.workspace_alias
  kms_key_arn = var.kms_key_arn

  dynamic "logging_configuration" {
    for_each = length(var.logging_configuration) > 0 ? [var.logging_configuration] : []

    content {
      log_group_arn = logging_configuration.value.log_group_arn
    }
  }

  tags = var.tags
}

################################################################################
# Alert Manager Definition
################################################################################

resource "aws_prometheus_alert_manager_definition" "this" {
  count = var.create && var.create_alert_manager ? 1 : 0

  workspace_id = local.workspace_id
  definition   = var.alert_manager_definition
}

################################################################################
# Rule Group Namespace
################################################################################

resource "aws_prometheus_rule_group_namespace" "this" {
  for_each = var.create ? var.rule_group_namespaces : {}

  name         = each.value.name
  workspace_id = local.workspace_id
  data         = each.value.data
}
