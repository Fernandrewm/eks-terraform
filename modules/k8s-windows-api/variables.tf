variable "project_name" {
  description = "Project name used for labeling"
  type        = string
}

variable "namespace" {
  description = "Namespace where Kubernetes resources will be created"
  type        = string
  default     = "default"
}

variable "service_name" {
  description = "Name of the Kubernetes service"
  type        = string
  default     = "windows-api-service"
}

variable "ingress_name" {
  description = "Name of the Kubernetes ingress"
  type        = string
  default     = "windows-api-ingress"
}

variable "service_port" {
  description = "Service port"
  type        = number
  default     = 80
}

variable "endpoint_ips" {
  description = "List of endpoint IPs for the service"
  type        = list(string)
}

variable "path" {
  description = "Path to route in the ingress"
  type        = string
  default     = "/api/inventario/"
}

variable "path_type" {
  description = "Path type for the ingress"
  type        = string
  default     = "Prefix"
}

variable "ingress_class_name" {
  description = "Ingress class name"
  type        = string
  default     = "nginx"
}

variable "labels" {
  description = "Additional labels to apply"
  type        = map(string)
  default     = {}
}

variable "ingress_annotations" {
  description = "Additional annotations for ingress"
  type        = map(string)
  default     = {}
}


