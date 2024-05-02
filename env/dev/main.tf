module "vpc" {
  source = "../../module/vpc"
  vpc    = var.vpc
  prefix = var.prefix
}
  
module "autoscaling_a" {
  source          = "../../module/autoscaling"
  auto_scaling     = var.auto_scaling.Trade_Staging_EC2
  private_subnet_ids = module.vpc.private_subnet_ids
  #target_group_arn  = module.loadbalancer.target_group_arn
  security_group_id = module.security_group.security_group_id
   prefix = var.prefix
}

module "autoscaling_b" {
  source          = "../../module/autoscaling"
  auto_scaling     = var.auto_scaling.Factor_EC2
  private_subnet_ids = module.vpc.private_subnet_ids
  #target_group_arn  = module.loadbalancer.target_group_arn
  security_group_id = module.security_group.security_group_id
   prefix = var.prefix
}

module "autoscaling_c" {
  source          = "../../module/autoscaling"
  auto_scaling     = var.auto_scaling.Daily_Scan_EC2
  private_subnet_ids = module.vpc.private_subnet_ids
  #target_group_arn  = module.loadbalancer.target_group_arn
  security_group_id = module.security_group.security_group_id
   prefix = var.prefix
}

module "security_group" {
  source         = "../../module/security_group"
  vpc_id         = module.vpc.vpc_id
  security_group = var.security_group
}