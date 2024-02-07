resource "aws_wafv2_ip_set" "default" {
  for_each = var.ip_sets

  name               = each.value.name
  description        = lookup(each.value, "description", null)
  scope              = var.scope
  ip_address_version = each.value.ip_address_version
  addresses          = each.value.addresses

  tags = each.value.tags
}
