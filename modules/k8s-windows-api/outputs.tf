output "service_name" {
  description = "Name of the Kubernetes service"
  value       = kubernetes_service_v1.windows_api.metadata[0].name
}

output "ingress_name" {
  description = "Name of the Kubernetes ingress"
  value       = kubernetes_ingress_v1.windows_api.metadata[0].name
}

output "namespace" {
  description = "Namespace where resources were created"
  value       = kubernetes_service_v1.windows_api.metadata[0].namespace
}


