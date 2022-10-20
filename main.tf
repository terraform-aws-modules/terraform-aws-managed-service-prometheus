################################################################################
# Workspace
################################################################################

resource "aws_prometheus_workspace" "this" {
  count = var.create && var.create_workspace ? 1 : 0

  alias = var.workspace_alias

  dynamic "logging_configuration" {
    for_each = var.enable_logging ? [0] : []
    content {
      log_group_arn = "${var.cloudwatch_log_group_arn}:*"
    }
  }

  tags = var.tags
}

################################################################################
# Alert Manager Definition
################################################################################

resource "aws_prometheus_alert_manager_definition" "this" {
  count = var.create ? 1 : 0

  workspace_id = var.create_workspace ? aws_prometheus_workspace.this[0].id : var.workspace_id
  definition   = var.alert_manager_definition
}

################################################################################
# Rule Group Namespace
################################################################################

resource "aws_prometheus_rule_group_namespace" "this" {
  for_each = var.create ? var.rule_group_namespaces : {}

  name         = each.value.name
  workspace_id = var.create_workspace ? aws_prometheus_workspace.this[0].id : var.workspace_id
  data         = each.value.data
}
