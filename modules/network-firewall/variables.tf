variable "firewall_name" {
  description = "The name of the Network Firewall"
  type        = string
}

variable "firewall_policy_name" {
  description = "The name of the Network Firewall Policy"
  type        = string
}

variable "rule_group_name" {
  description = "The name of the Network Firewall Rule Group"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "The ID of the subnet"
  type        = list(string)
  default = [ ]
}

variable "domain_whitelist_rule_group_name" {
  description = "The name of the Network Firewall Rule Group for domain whitelisting"
  type        = string
}
