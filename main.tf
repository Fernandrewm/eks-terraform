terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

module "network" {
  source = "./modules/network"

  vpc_name = var.vpc_name
  vpc_cidr = var.vpc_cidr
  vpc_azs = var.vpc_azs
  vpc_public_subnets = var.vpc_public_subnets
  vpc_private_subnets = var.vpc_private_subnets
}