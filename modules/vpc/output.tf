# outputs.tf

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.network_vpc.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.network_vpc.cidr_block
}

output "private_subnets" {
  value =[for subnet in aws_subnet.network_private_subnets : {id: subnet.id, name: subnet.tags["Name"]}]
}