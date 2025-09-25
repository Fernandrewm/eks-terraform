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

output "frontend_dashboard_repository_url" {
  description = "URL of the ECR repository for frontend-dashboard"
  value       = module.ecr.frontend_dashboard_repository_url
}

output "backend_ventas_repository_url" {
  description = "URL of the ECR repository for backend-ventas"
  value       = module.ecr.backend_ventas_repository_url
}

output "windows_api_instance_id" {
  description = "ID of the Windows API EC2 instance"
  value       = module.ec2.instance_id
}

output "windows_api_public_ip" {
  description = "Public IP address of the Windows API EC2 instance"
  value       = module.ec2.public_ip
}

output "windows_api_security_group_id" {
  description = "Security group ID of the Windows API EC2 instance"
  value       = module.ec2.security_group_id
}

output "windows_api_private_key_path" {
  description = "Path to the generated private key for the Windows API EC2 instance"
  value       = module.ec2.private_key_path
}

output "windows_api_service_name" {
  description = "Kubernetes service name for the Windows API"
  value       = module.k8s_windows_api.service_name
}

output "windows_api_ingress_name" {
  description = "Kubernetes ingress name for the Windows API"
  value       = module.k8s_windows_api.ingress_name
}

output "windows_api_namespace" {
  description = "Namespace where the Windows API Kubernetes resources were created"
  value       = module.k8s_windows_api.namespace
}