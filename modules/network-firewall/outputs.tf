output "firewall_arn" {
  description = "The ARN of the Network Firewall"
  value       = aws_networkfirewall_firewall.main-firewall.arn
}

output "firewall_policy_arn" {
  description = "The ARN of the Network Firewall Policy"
  value       = aws_networkfirewall_firewall_policy.main-firewall.arn
}

output "rule_group_arn" {
  description = "The ARN of the Network Firewall Rule Group"
  value       = aws_networkfirewall_rule_group.main-firewall.arn
}

/* output "domain_whitelist_rule_group_arn" {
  description = "The ARN of the Network Firewall Rule Group for domain whitelisting"
  value       = aws_networkfirewall_rule_group.domain-whitelist.arn
} */
