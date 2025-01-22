module "transit_gateway" {
  source = "./modules/transit-gateway"

  description     = "My Transit Gateway"
  amazon_side_asn = 64512
  tags = {
    Name = "MyTransitGateway"
  }
}

// ...existing code...
