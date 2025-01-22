output "id" {
  description = "The ID of the transit gateway"
  value       = aws_ec2_transit_gateway.this.id
}

output "arn" {
  description = "The ARN of the transit gateway"
  value       = aws_ec2_transit_gateway.this.arn
}
