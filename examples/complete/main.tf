provider "aws" {
  region = local.region
}

data "aws_caller_identity" "current" {}

locals {
  region = "us-east-1"
  name   = "amp-ex-${basename(path.cwd)}"
}

################################################################################
# Prometheus Module
################################################################################

module "prometheus" {
  source = "../.."

  workspace_alias = local.name
  logging_configuration = {
    create_log_group = true
    # To use externally created log group
    # log_group_arn = "${aws_cloudwatch_log_group.this.arn}:*"
  }

  retention_period_in_days = 60

  limits_per_label_set = [
    {
      label_set = {
        "env" = "dev"
      }
      limits = {
        max_series = 100000
      }
    },
    {
      label_set = {
        "env" = "prod"
      }
      limits = {
        max_series = 400000
      }
    }
  ]

  create_resource_policy = true
  resource_policy_statements = {
    something = {
      sid = "OtherAccountRead"
      principals = [{
        type        = "AWS"
        identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
      }]
      actions = [
        "aps:QueryMetrics",
        "aps:GetSeries",
        "aps:GetLabels",
        "aps:GetMetricMetadata",
      ]
    }
  }

  create_alert_manager     = true
  alert_manager_definition = <<-EOT
  alertmanager_config: |
    route:
      receiver: 'default'
    receivers:
      - name: 'default'
  EOT

  rule_group_namespaces = {
    first = {
      name = "${local.name}-01"
      data = <<-EOT
      groups:
        - name: test
          rules:
          - record: metric:recording_rule
            expr: avg(rate(container_cpu_usage_seconds_total[5m]))
      EOT
    }
    second = {
      name = "${local.name}-02"
      data = <<-EOT
      groups:
        - name: test
          rules:
          - record: metric:recording_rule
            expr: avg(rate(container_cpu_usage_seconds_total[5m]))
      EOT
    }
  }
}

module "default" {
  source = "../.."

  workspace_alias = "${local.name}-default"
}

module "disabled" {
  source = "../.."

  create = false
}
