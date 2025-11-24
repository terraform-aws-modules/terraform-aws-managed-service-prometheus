variable "create" {
  description = "Determines whether a resources will be created"
  type        = bool
  default     = true
}

variable "region" {
  description = "Region where the resource(s) will be managed. Defaults to the Region set in the provider configuration"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# Workspace
################################################################################

variable "create_workspace" {
  description = "Determines whether a workspace will be created or to use an existing workspace"
  type        = bool
  default     = true
}

variable "workspace_id" {
  description = "The ID of an existing workspace to use when `create_workspace` is `false`"
  type        = string
  default     = ""
}

variable "workspace_alias" {
  description = "The alias of the prometheus workspace. See more in the [AWS Docs](https://docs.aws.amazon.com/prometheus/latest/userguide/AMP-onboard-create-workspace.html)"
  type        = string
  default     = null
}

variable "logging_configuration" {
  description = "The logging configuration of the prometheus workspace."
  type = object({
    create_log_group      = optional(bool, true)
    logging_configuration = optional(string)
  })
  default = null
}

variable "kms_key_arn" {
  description = "The ARN of the KMS Key to for encryption at rest"
  type        = string
  default     = null
}

################################################################################
# Workspace Configuration
################################################################################

variable "retention_period_in_days" {
  description = "Number of days to retain metric data in the workspace"
  type        = number
  default     = null
}

variable "limits_per_label_set" {
  description = "Configuration block for setting limits on metrics with specific label sets"
  type = list(object({
    label_set = map(string)
    limits = object({
      max_series = number
    })
  }))
  default = null
}

variable "attach_policy" {
  description = "Controls if Prometheus Workspace should have policy attached (set to `true` to use value of `policy` as Prometheus Workspace policy)"
  type        = bool
  default     = false
}

variable "policy" {
  description = "(Optional) A valid policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide."
  type        = string
  default     = null
}

################################################################################
# CloudWatch Log Group
################################################################################

variable "cloudwatch_log_group_name" {
  description = "Custom name of CloudWatch log group for a service associated with the container definition"
  type        = string
  default     = null
}

variable "cloudwatch_log_group_use_name_prefix" {
  description = "Determines whether the log group name should be used as a prefix"
  type        = bool
  default     = false
}

variable "cloudwatch_log_group_class" {
  description = "Specified the log class of the log group. Possible values are: `STANDARD` or `INFREQUENT_ACCESS`"
  type        = string
  default     = null
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "Number of days to retain log events. Set to `0` to keep logs indefinitely"
  type        = number
  default     = 30
}

variable "cloudwatch_log_group_kms_key_id" {
  description = "If a KMS Key ARN is set, this key will be used to encrypt the corresponding log group. Please be sure that the KMS Key has an appropriate key policy (https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/encrypt-log-data-kms.html)"
  type        = string
  default     = null
}

################################################################################
# Alert Manager Definition
################################################################################

variable "create_alert_manager" {
  description = "Controls whether an Alert Manager definition is created along with the AMP workspace"
  type        = bool
  default     = true
}

variable "alert_manager_definition" {
  description = "The alert manager definition that you want to be applied. See more in the [AWS Docs](https://docs.aws.amazon.com/prometheus/latest/userguide/AMP-alert-manager.html)"
  type        = string
  default     = <<-EOT
    alertmanager_config: |
      route:
        receiver: 'default'
      receivers:
        - name: 'default'
  EOT
}

################################################################################
# Rule Group Namespace
################################################################################

variable "rule_group_namespaces" {
  description = "A map of one or more rule group namespace definitions"
  type = map(object({
    name = string
    data = string
  }))
  default = null
}
