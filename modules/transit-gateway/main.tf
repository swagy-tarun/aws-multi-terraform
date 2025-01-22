resource "aws_ec2_transit_gateway" "this" {
  description = var.description
  amazon_side_asn = var.amazon_side_asn
  default_route_table_association = var.association
  default_route_table_propagation = var.propagation
  auto_accept_shared_attachments =  var.auto_accept_shared_attachments

  tags = var.tags
}
