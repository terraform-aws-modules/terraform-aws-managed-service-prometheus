provider "aws" {
  region = local.region
}

locals {
  region = "us-east-1"
  name   = "example-${replace(basename(path.cwd), "_", "-")}"
}

################################################################################
# Prometheus Module
################################################################################

module "disabled" {
  source = "../.."

  create = false
}

module "prometheus" {
  source = "../.."

  workspace_alias = local.name

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
