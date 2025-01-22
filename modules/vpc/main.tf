# main.tf

resource "aws_vpc" "network_vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    var.vpc_tags,
    {
      "Name" = var.vpc_name
    }
  )
}

# Public subnets
resource "aws_subnet" "network_public_subnets" {
  for_each = { for subnet in var.public_subnets : subnet.name => subnet }

  vpc_id            = aws_vpc.network_vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = "${var.vpc_name}-${each.value.name}"
    Key = "${each.value.name}"
  }
}

# Private Subnets
resource "aws_subnet" "network_private_subnets" {
  for_each = { for subnet in var.private_subnets : subnet.name => subnet }

  vpc_id            = aws_vpc.network_vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = "${var.vpc_name}-${each.value.name}"
    Key = "${each.value.name}"
  }
}

# IGW 

resource "aws_internet_gateway" "network_igw" {
  count = length(aws_subnet.network_public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.network_vpc.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }  
}

# Route Tables

resource "aws_route_table" "network_public_route_table" {
  count = length(aws_subnet.network_public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.network_vpc.id

  tags = {
    Name = "${var.vpc_name}-public-rt"
  }

}

# Default Route to Internet Gateway
resource "aws_route" "network_public_route" {
  count = length(aws_subnet.network_public_subnets) > 0 ? 1 : 0

  route_table_id         = aws_route_table.network_public_route_table[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.network_igw[0].id
}


# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public_subnet_association" {
  for_each       = aws_subnet.network_public_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.network_public_route_table[0].id
}