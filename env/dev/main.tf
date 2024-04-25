module "vpc" {
  source = "../../module/vpc"
  vpc    = var.vpc
  prefix = var.prefix
}

