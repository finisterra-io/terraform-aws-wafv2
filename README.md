
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
| [aws_wafv2_web_acl.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl) | resource |
| [aws_wafv2_web_acl_association.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association) | resource |
| [aws_wafv2_web_acl_logging_configuration.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_logging_configuration) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_association_resource_arns"></a> [association\_resource\_arns](#input\_association\_resource\_arns) | A list of ARNs of the resources to associate with the web ACL.<br>This must be an ARN of an Application Load Balancer, Amazon API Gateway stage, or AWS AppSync.<br><br>Do not use this variable to associate a Cloudfront Distribution.<br>Instead, you should use the `web_acl_id` property on the `cloudfront_distribution` resource.<br>For more details, refer to https://docs.aws.amazon.com/waf/latest/APIReference/API_AssociateWebACL.html | `list(string)` | `[]` | no |
| <a name="input_custom_response_body"></a> [custom\_response\_body](#input\_custom\_response\_body) | Defines custom response bodies that can be referenced by custom\_response actions.<br>The map keys are used as the `key` attribute which is a unique key identifying the custom response body.<br>content:<br>  Payload of the custom response.<br>  The response body can be plain text, HTML or JSON and cannot exceed 4KB in size.<br>content\_type:<br>  Content Type of Response Body.<br>  Valid values are `TEXT_PLAIN`, `TEXT_HTML`, or `APPLICATION_JSON`. | `list(any)` | `[]` | no |
| <a name="input_default_action"></a> [default\_action](#input\_default\_action) | Specifies that AWS WAF should allow requests by default. Possible values: `allow`, `block`. | `list(any)` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | A friendly description of the WebACL. | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to `false` to prevent the module from creating any resources. | `bool` | `true` | no |
| <a name="input_log_destination_configs"></a> [log\_destination\_configs](#input\_log\_destination\_configs) | The Amazon Kinesis Data Firehose, CloudWatch Log log group, or S3 bucket Amazon Resource Names (ARNs) that you want to associate with the web ACL | `list(string)` | `[]` | no |
| <a name="input_logging_filter"></a> [logging\_filter](#input\_logging\_filter) | A configuration block that specifies which web requests are kept in the logs and which are dropped.<br>You can filter on the rule action and on the web request labels that were applied by matching rules during web ACL evaluation. | `list(any)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | A friendly name of the WebACL. | `string` | n/a | yes |
| <a name="input_redacted_fields"></a> [redacted\_fields](#input\_redacted\_fields) | The parts of the request that you want to keep out of the logs.<br>You can only specify one of the following: `method`, `query_string`, `single_header`, or `uri_path`<br><br>method:<br>  Whether to enable redaction of the HTTP method.<br>  The method indicates the type of operation that the request is asking the origin to perform.<br>uri\_path:<br>  Whether to enable redaction of the URI path.<br>  This is the part of a web request that identifies a resource.<br>query\_string:<br>  Whether to enable redaction of the query string.<br>  This is the part of a URL that appears after a `?` character, if any.<br>single\_header:<br>  The list of names of the query headers to redact. | <pre>map(object({<br>    method        = optional(bool, false)<br>    uri_path      = optional(bool, false)<br>    query_string  = optional(bool, false)<br>    single_header = optional(list(string), null)<br>  }))</pre> | `{}` | no |
| <a name="input_rules"></a> [rules](#input\_rules) | A list of rule configuration objects. See the documentation for the `rules` argument in the `aws_wafv2_web_acl` resource for more details. | `list(any)` | `[]` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | Specifies whether this is for an AWS CloudFront distribution or for a regional application.<br>Possible values are `CLOUDFRONT` or `REGIONAL`.<br>To work with CloudFront, you must also specify the region us-east-1 (N. Virginia) on the AWS provider. | `string` | `"REGIONAL"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource. | `map(string)` | `{}` | no |
| <a name="input_token_domains"></a> [token\_domains](#input\_token\_domains) | Specifies the domains that AWS WAF should accept in a web request token.<br>This enables the use of tokens across multiple protected websites.<br>When AWS WAF provides a token, it uses the domain of the AWS resource that the web ACL is protecting.<br>If you don't specify a list of token domains, AWS WAF accepts tokens only for the domain of the protected resource.<br>With a token domain list, AWS WAF accepts the resource's host domain plus all domains in the token domain list,<br>including their prefixed subdomains. | `list(string)` | `null` | no |
| <a name="input_visibility_config"></a> [visibility\_config](#input\_visibility\_config) | Defines and enables Amazon CloudWatch metrics and web request sample collection.<br><br>cloudwatch\_metrics\_enabled:<br>  Whether the associated resource sends metrics to CloudWatch.<br>metric\_name:<br>  A friendly name of the CloudWatch metric.<br>sampled\_requests\_enabled:<br>  Whether AWS WAF should store a sampling of the web requests that match the rules. | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the WAF WebACL. |
| <a name="output_capacity"></a> [capacity](#output\_capacity) | The web ACL capacity units (WCUs) currently being used by this web ACL. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the WAF WebACL. |
| <a name="output_logging_config_id"></a> [logging\_config\_id](#output\_logging\_config\_id) | The ARN of the WAFv2 Web ACL logging configuration. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
