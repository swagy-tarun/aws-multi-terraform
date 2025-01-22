resource "aws_networkfirewall_firewall" "main-firewall" {
  name                = var.firewall_name
  firewall_policy_arn = aws_networkfirewall_firewall_policy.main-firewall.arn
  vpc_id              = var.vpc_id
  dynamic "subnet_mapping" {
    for_each = var.subnet_ids
    content {
      subnet_id = subnet_mapping.value
    }
  }
}

resource "aws_networkfirewall_firewall_policy" "main-firewall" {
  name = var.firewall_policy_name

  firewall_policy {
    stateless_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.main-firewall.arn
      priority     = 1
    }
/*     stateless_rule_group_reference {
      resource_arn = aws_networkfirewall_rule_group.domain-whitelist.arn
      priority     = 2
    } */
    stateless_default_actions          = ["aws:forward_to_sfe"]
    stateless_fragment_default_actions = ["aws:forward_to_sfe"]
  }
}

resource "aws_networkfirewall_rule_group" "main-firewall" {
  capacity = 100
  name     = var.rule_group_name
  type     = "STATEFUL"

  rule_group {
    rules_source {
      rules_string = <<RULES
              {
                \"rulesSourceList\": {
                  \"targets\": [\"0.0.0.0/0\"],
                  \"targetTypes\": [\"TLS_SNI\"],
                  \"generatedRulesType\": \"ALLOWLIST\"
                }
              }
            RULES
    }
  }
}

/* resource "aws_networkfirewall_rule_group" "domain-whitelist" {
  capacity = 100
  name     = var.domain_whitelist_rule_group_name
  type     = "STATEFUL"

  rule_group {
    rules_source {
      rules_string = <<RULES
        {
          "rulesSourceList": {
            "targets": ["example.com", "anotherdomain.com"],
            "targetTypes": ["HTTP_HOST"],
            "generatedRulesType": "ALLOWLIST"
          }
        }
      RULES
    }
  }
} */
