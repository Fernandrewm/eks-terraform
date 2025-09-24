variable "project_name" {
  description = "Project name"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet where the instance will be deployed"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

variable "instance_type" {
  description = "Instance type for the Windows API EC2 instance"
  type        = string
  default     = "t3.medium"
}

variable "ami" {
  description = "AMI ID for the Windows API EC2 instance"
  type        = string
  default     = "ami-07f134e32cbbbfc98"
}

variable "key_pair_name" {
  description = "Name for the EC2 key pair"
  type        = string
  default     = "eks-terraform-windows-api"
}

variable "private_key_output_path" {
  description = "Path where the generated private key will be stored"
  type        = string
  default     = "generated/windows-api-key.pem"
}

variable "http_ingress_cidrs" {
  description = "List of CIDR blocks allowed to access the instance over HTTP"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}


