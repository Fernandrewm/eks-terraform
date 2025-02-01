module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.18.1"

  name = var.vpc_name
  cidr = var.vpc_cidr
  azs = var.vpc_azs
  public_subnets = var.vpc_public_subnets
  private_subnets = var.vpc_private_subnets
}