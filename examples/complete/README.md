# Complete AWS Managed Service for Prometheus (AMP) Example

Configuration in this directory creates:

- AMP workspace
- AMP alert manager definition
- AMP rule group namespaces

## Usage

To run this example you need to execute:

```bash
terraform init
terraform plan
terraform apply
```

Note that this example may create resources which will incur monetary charges on your AWS bill. Run `terraform destroy` when you no longer need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_default"></a> [default](#module\_default) | ../.. | n/a |
| <a name="module_disabled"></a> [disabled](#module\_disabled) | ../.. | n/a |
| <a name="module_prometheus"></a> [prometheus](#module\_prometheus) | ../.. | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_workspace_arn"></a> [workspace\_arn](#output\_workspace\_arn) | Amazon Resource Name (ARN) of the workspace |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | Identifier of the workspace |
| <a name="output_workspace_prometheus_endpoint"></a> [workspace\_prometheus\_endpoint](#output\_workspace\_prometheus\_endpoint) | Prometheus endpoint available for this workspace |
<!-- END_TF_DOCS -->

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-managed-service-prometheus/blob/master/LICENSE).
