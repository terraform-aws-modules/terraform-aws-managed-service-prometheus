variable "create" {
  description = "Determines whether a resources will be created"
  type        = bool
  default     = true
}

# aws_prometheus_workspace
variable "workspace_alias" {
  description = "The alias of the prometheus workspace. See more in the [AWS Docs](https://docs.aws.amazon.com/prometheus/latest/userguide/AMP-onboard-create-workspace.html)"
  type        = string
  default     = null
}

# aws_prometheus_alert_manager_definition
variable "alert_manager_definition" {
  description = "The alert manager definition that you want to be applied. See more in the [AWS Docs](https://docs.aws.amazon.com/prometheus/latest/userguide/AMP-alert-manager.html)"
  type        = string
  default     = null
}

# aws_prometheus_rule_group_namespace
variable "rule_group_namespaces" {
  description = "A map of one or more rule group namespace definitions"
  type        = map(any)
  default     = {}
}
