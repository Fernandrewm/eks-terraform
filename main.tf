provider "aws" {
  region = "us-west-2"
}

locals {
  project_name = "eks-terraform"
  common_tags = {
    Project     = local.project_name
    Environment = "test"
    Terraform   = "true"
  }
}

module "vpc" {
  source = "./modules/vpc"

  project_name = local.project_name
  vpc_cidr     = "10.0.0.0/16"
  tags         = local.common_tags
}

module "subnets" {
  source = "./modules/subnets"

  project_name = local.project_name
  vpc_id       = module.vpc.vpc_id

  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones   = ["us-west-2a", "us-west-2b"]
  
  tags = local.common_tags
}

module "gateways" {
  source = "./modules/gateways"

  project_name       = local.project_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.subnets.public_subnet_ids
  private_subnet_ids = module.subnets.private_subnet_ids
  tags              = local.common_tags

  depends_on = [module.vpc, module.subnets]
}
