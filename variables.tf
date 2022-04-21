variable "create" {
  description = "Determines whether a resources will be created"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# Workspace
################################################################################

variable "workspace_alias" {
  description = "The alias of the prometheus workspace. See more in the [AWS Docs](https://docs.aws.amazon.com/prometheus/latest/userguide/AMP-onboard-create-workspace.html)"
  type        = string
  default     = null
}

################################################################################
# Alert Manager Definition
################################################################################

variable "alert_manager_definition" {
  description = "The alert manager definition that you want to be applied. See more in the [AWS Docs](https://docs.aws.amazon.com/prometheus/latest/userguide/AMP-alert-manager.html)"
  type        = string
  default     = <<EOF
alertmanager_config: |
  route:
    receiver: 'default'
  receivers:
    - name: 'default'
EOF
}

################################################################################
# Rule Group Namespace
################################################################################

variable "rule_group_namespaces" {
  description = "A map of one or more rule group namespace definitions"
  type        = map(any)
  default     = {}
}
