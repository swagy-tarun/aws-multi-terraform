module "network_vpc" {
  source = "../../../modules/vpc"
  vpc_name = "ingress"
  cidr_block = "172.16.0.0/24"
  enable_dns_hostnames = false
  enable_dns_support = true
  public_subnets = [{name = "ingress-public-subnet-1", cidr_block = "172.16.0.0/27", availability_zone = "${var.Region}a"},
                    {name = "ingress-public-subnet-2", cidr_block = "172.16.0.32/27", availability_zone = "${var.Region}b"},
                    {name = "ingress-public-subnet-3", cidr_block = "172.16.0.64/27", availability_zone = "${var.Region}c"}]
  
  private_subnets = [{name = "ingress-private-subnet-1", cidr_block = "172.16.0.96/27", availability_zone = "${var.Region}a"},
                    {name = "ingress-private-subnet-2", cidr_block = "172.16.0.128/27", availability_zone = "${var.Region}b"},
                    {name = "ingress-private-subnet-3", cidr_block = "172.16.0.160/27", availability_zone = "${var.Region}c"}]
  vpc_tags = {
    Environment = var.Environment
    Owner = var.Owner
  }
}
