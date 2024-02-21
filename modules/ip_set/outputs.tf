output "id" {
  value       = aws_wafv2_ip_set.default[0].id
  description = "The ID of the IP set"
}

output "arn" {
  value       = aws_wafv2_ip_set.default[0].arn
  description = "The ARN of the IP set"
}
