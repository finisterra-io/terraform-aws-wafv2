# ip_set

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.67 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.67 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_wafv2_ip_set.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_ip_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addresses"></a> [addresses](#input\_addresses) | The list of IP addresses in CIDR notation | `list(string)` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | The description of the IP set | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `true` | no |
| <a name="input_ip_address_version"></a> [ip\_address\_version](#input\_ip\_address\_version) | The IP address version of the IP set | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the IP set | `string` | n/a | yes |
| <a name="input_scope"></a> [scope](#input\_scope) | The scope of the IP set | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the IP set |
| <a name="output_id"></a> [id](#output\_id) | The ID of the IP set |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
