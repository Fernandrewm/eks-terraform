output "frontend_dashboard_repository_url" {
  description = "URL of the ECR repository for frontend-dashboard"
  value       = aws_ecr_repository.frontend_dashboard.repository_url
}

output "backend_ventas_repository_url" {
  description = "URL of the ECR repository for backend-ventas"
  value       = aws_ecr_repository.backend_ventas.repository_url
}

