variable "enabled" {
  description = "Set to false to prevent the module from creating any resources"
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the IP set"
  type        = string
}

variable "description" {
  description = "The description of the IP set"
  type        = string
  default     = null
}

variable "scope" {
  description = "The scope of the IP set"
  type        = string
}

variable "ip_address_version" {
  description = "The IP address version of the IP set"
  type        = string
}

variable "addresses" {
  description = "The list of IP addresses in CIDR notation"
  type        = list(string)
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

