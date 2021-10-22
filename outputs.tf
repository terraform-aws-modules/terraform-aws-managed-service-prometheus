# aws_prometheus_workspace
output "workspace_arn" {
  description = "Amazon Resource Name (ARN) of the workspace"
  value       = try(aws_prometheus_workspace.this[0].arn, "")
}

output "workspace_id" {
  description = "Identifier of the workspace"
  value       = try(aws_prometheus_workspace.this[0].id, "")
}

output "workspace_prometheus_endpoint" {
  description = "Prometheus endpoint available for this workspace"
  value       = try(aws_prometheus_workspace.this[0].prometheus_endpoint, "")
}
