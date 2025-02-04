variable "project_name" {
  description = "Project name"
  type        = string
}

variable "cluster_name" {
  description = "Cluster name"
  type        = string
}

variable "cluster_endpoint" {
  description = "Cluster endpoint"
  type        = string
}

variable "cluster_oidc_issuer" {
  description = "Cluster OIDC issuer"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}