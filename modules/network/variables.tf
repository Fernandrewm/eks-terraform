variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_azs" {
  description = "A list of availability zones in the region"
  type        = list(string)
}

variable "vpc_public_subnets" {
  description = "A list of public subnet CIDR blocks"
  type        = list(string)
}

variable "vpc_private_subnets" {
  description = "A list of private subnet CIDR blocks"
  type        = list(string)
}