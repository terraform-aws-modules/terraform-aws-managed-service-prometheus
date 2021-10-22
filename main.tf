resource "aws_prometheus_workspace" "this" {
  count = var.create ? 1 : 0

  alias = var.workspace_alias
}

resource "aws_prometheus_alert_manager_definition" "this" {
  count = var.create ? 1 : 0

  workspace_id = aws_prometheus_workspace.this[0].id
  definition   = var.alert_manager_definition
}

resource "aws_prometheus_rule_group_namespace" "this" {
  for_each = var.create ? var.rule_group_namespaces : {}

  name         = each.value.name
  workspace_id = aws_prometheus_workspace.this[0].id
  data         = each.value.data
}
