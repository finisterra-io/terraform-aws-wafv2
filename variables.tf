variable "enabled" {
  type        = bool
  default     = true
  description = "Set to `false` to prevent the module from creating any resources."
}

variable "name" {
  type        = string
  description = "A friendly name of the WebACL."
}

variable "description" {
  type        = string
  default     = "Managed by Terraform"
  description = "A friendly description of the WebACL."
}

variable "default_action" {
  type        = list(any)
  description = "Specifies that AWS WAF should allow requests by default. Possible values: `allow`, `block`."
}

variable "custom_response_body" {
  type = list(any)

  description = <<-DOC
    Defines custom response bodies that can be referenced by custom_response actions.
    The map keys are used as the `key` attribute which is a unique key identifying the custom response body.
    content:
      Payload of the custom response.
      The response body can be plain text, HTML or JSON and cannot exceed 4KB in size.
    content_type:
      Content Type of Response Body.
      Valid values are `TEXT_PLAIN`, `TEXT_HTML`, or `APPLICATION_JSON`.
  DOC
  default     = []
}

variable "scope" {
  type        = string
  default     = "REGIONAL"
  description = <<-DOC
    Specifies whether this is for an AWS CloudFront distribution or for a regional application.
    Possible values are `CLOUDFRONT` or `REGIONAL`.
    To work with CloudFront, you must also specify the region us-east-1 (N. Virginia) on the AWS provider.
  DOC
  validation {
    condition     = contains(["CLOUDFRONT", "REGIONAL"], var.scope)
    error_message = "Allowed values: `CLOUDFRONT`, `REGIONAL`."
  }
}

variable "visibility_config" {
  type        = list(any)
  description = <<-DOC
    Defines and enables Amazon CloudWatch metrics and web request sample collection.

    cloudwatch_metrics_enabled:
      Whether the associated resource sends metrics to CloudWatch.
    metric_name:
      A friendly name of the CloudWatch metric.
    sampled_requests_enabled:
      Whether AWS WAF should store a sampling of the web requests that match the rules.
  DOC
  default     = []
}

variable "token_domains" {
  type        = list(string)
  description = <<-DOC
    Specifies the domains that AWS WAF should accept in a web request token.
    This enables the use of tokens across multiple protected websites.
    When AWS WAF provides a token, it uses the domain of the AWS resource that the web ACL is protecting.
    If you don't specify a list of token domains, AWS WAF accepts tokens only for the domain of the protected resource.
    With a token domain list, AWS WAF accepts the resource's host domain plus all domains in the token domain list,
    including their prefixed subdomains.
  DOC
  default     = null
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_logging_configuration.html
variable "log_destination_configs" {
  type        = list(string)
  default     = []
  description = "The Amazon Kinesis Data Firehose, CloudWatch Log log group, or S3 bucket Amazon Resource Names (ARNs) that you want to associate with the web ACL"
}

variable "redacted_fields" {
  type = map(object({
    method        = optional(bool, false)
    uri_path      = optional(bool, false)
    query_string  = optional(bool, false)
    single_header = optional(list(string), null)
  }))
  default     = {}
  description = <<-DOC
    The parts of the request that you want to keep out of the logs.
    You can only specify one of the following: `method`, `query_string`, `single_header`, or `uri_path`

    method:
      Whether to enable redaction of the HTTP method.
      The method indicates the type of operation that the request is asking the origin to perform.
    uri_path:
      Whether to enable redaction of the URI path.
      This is the part of a web request that identifies a resource.
    query_string:
      Whether to enable redaction of the query string.
      This is the part of a URL that appears after a `?` character, if any.
    single_header:
      The list of names of the query headers to redact.
  DOC
}

variable "logging_filter" {
  type        = list(any)
  default     = []
  description = <<-DOC
    A configuration block that specifies which web requests are kept in the logs and which are dropped.
    You can filter on the rule action and on the web request labels that were applied by matching rules during web ACL evaluation.
  DOC
}

# Association resource ARNs
variable "association_resource_arns" {
  type        = list(string)
  default     = []
  description = <<-DOC
    A list of ARNs of the resources to associate with the web ACL.
    This must be an ARN of an Application Load Balancer, Amazon API Gateway stage, or AWS AppSync.

    Do not use this variable to associate a Cloudfront Distribution.
    Instead, you should use the `web_acl_id` property on the `cloudfront_distribution` resource.
    For more details, refer to https://docs.aws.amazon.com/waf/latest/APIReference/API_AssociateWebACL.html
  DOC
}

variable "rules" {
  type        = list(any)
  description = "A list of rule configuration objects. See the documentation for the `rules` argument in the `aws_wafv2_web_acl` resource for more details."
  default     = []
}

variable "ip_sets" {
  type        = map(any)
  default     = {}
  description = "A list of IP Set configuration objects."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the resource."
}
