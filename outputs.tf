output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.subnets.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.subnets.private_subnet_ids
}

output "nat_gateway_eip" {
  description = "Elastic IP assigned to the NAT Gateway"
  value       = module.gateways.nat_gateway_eip
}