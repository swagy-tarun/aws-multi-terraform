module "network_ingress_vpc" {
  source = "../../../modules/vpc"
  vpc_name = "ingress"
  cidr_block = "172.16.0.0/24"
  enable_dns_hostnames = false
  enable_dns_support = true
  public_subnets = [{name = "ingress-public-subnet-1", cidr_block = "172.16.0.0/27", availability_zone = "${var.Region}a"},
                    {name = "ingress-public-subnet-2", cidr_block = "172.16.0.32/27", availability_zone = "${var.Region}b"},
                    {name = "ingress-public-subnet-3", cidr_block = "172.16.0.64/27", availability_zone = "${var.Region}c"}]
  
  private_subnets = [{name = "ingress-private-tgw-subnet-1", cidr_block = "172.16.0.96/27", availability_zone = "${var.Region}a"},
                    {name = "ingress-private-tgw-subnet-2", cidr_block = "172.16.0.128/27", availability_zone = "${var.Region}b"},
                    {name = "ingress-private-tgw-subnet-3", cidr_block = "172.16.0.160/27", availability_zone = "${var.Region}c"}]
  vpc_tags = {
    Environment = var.Environment
    Owner = var.Owner
  }
}

module "network_inspection_vpc" {
  source = "../../../modules/vpc"
  vpc_name = "inspection"
  cidr_block = "100.64.0.0/24"
  enable_dns_hostnames = false
  enable_dns_support = false
  private_subnets = [{name = "inspection-private-tgw-subnet-1", cidr_block = "100.64.0.0/27", availability_zone = "${var.Region}a"},
                    {name = "inspection-private-tgw-subnet-2", cidr_block = "100.64.0.32/27", availability_zone = "${var.Region}b"},
                    {name = "inspection-private-tgw-subnet-3", cidr_block = "100.64.0.64/27", availability_zone = "${var.Region}c"},
                    {name = "inspection-private-firewall-subnet-1", cidr_block = "100.64.0.96/27", availability_zone = "${var.Region}a"},
                    {name = "inspection-private-firewall-subnet-2", cidr_block = "100.64.0.128/27", availability_zone = "${var.Region}b"},
                    {name = "inspection-private-firewall-subnet-3", cidr_block = "100.64.0.160/27", availability_zone = "${var.Region}c"}]
  vpc_tags = {
    Environment = var.Environment
    Owner = var.Owner
  }
}

/* module "transit_gateway" {
  source = "../../../modules/transit-gateway"
  description = "Cross Account Transit Gateway to connect Network VPCs and WorkLoad VPCs"
  auto_accept_shared_attachments = "enable"
  tags = {
    Name = "main-transit-gateway"
  }
} */

module "network_firewall_inspection_vpc" {
  source = "../../../modules/network-firewall"
  vpc_id = module.network_inspection_vpc.vpc_id
  domain_whitelist_rule_group_name = "example-domain-whitelist"
  firewall_name = "example-firewall"
  firewall_policy_name = "example-firewall-policy"
  rule_group_name = "example-rule-group"
  subnet_ids = [for subnet in module.network_inspection_vpc.private_subnets : subnet.id if can(regex("inspection-private-firewall-subnet", subnet.name))]
}