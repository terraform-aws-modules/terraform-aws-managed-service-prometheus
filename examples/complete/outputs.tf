################################################################################
# Workspace
################################################################################

output "workspace_arn" {
  description = "Amazon Resource Name (ARN) of the workspace"
  value       = module.prometheus.workspace_arn
}

output "workspace_id" {
  description = "Identifier of the workspace"
  value       = module.prometheus.workspace_id
}

output "workspace_prometheus_endpoint" {
  description = "Prometheus endpoint available for this workspace"
  value       = module.prometheus.workspace_prometheus_endpoint
}
