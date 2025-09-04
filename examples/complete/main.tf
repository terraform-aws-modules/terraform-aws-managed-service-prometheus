provider "aws" {
  region = local.region
}

locals {
  region = "us-east-1"
  name   = "amp-ex-${replace(basename(path.cwd), "_", "-")}"
}

################################################################################
# Prometheus Module
################################################################################

module "prometheus" {
  source = "../.."

  workspace_alias = local.name
  logging_configuration = {
    log_group_arn = "${aws_cloudwatch_log_group.this.arn}:*"
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

module "disabled" {
  source = "../.."

  create = false
}

module "default" {
  source = "../.."

  workspace_alias = "${local.name}-default"
}

################################################################################
# Supporting Resources
################################################################################
resource "aws_cloudwatch_log_group" "this" {
  name = "example-aws-managed-service-prometheus-complete"
}
