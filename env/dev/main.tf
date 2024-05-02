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

module "s3" {
   source        = "../../module/s3"
   s3            = var.s3
   prefix        = var.prefix
 }

module "rds" {
  source       = "../../module/rds"
  rds          = var.rds
  vpc_id       = module.vpc.vpc_id
  subnets      = local.subnet_ids
  bastion_host_sg = module.bastion_sg.bastion_sg_id
  prefix       = var.prefix
}

module "Quandl_import_lambda" {
  source       = "../../module/import_lambda"
  import_lambda = var.import_lambda.Quandl_Import
  prefix       = var.prefix
}

module "Norgate_import_lambda" {
  source       = "../../module/import_lambda"
  import_lambda = var.import_lambda.Norgate_Import
  prefix       = var.prefix
}

module "Polygon_import_lambda" {
  source       = "../../module/import_lambda"
  import_lambda = var.import_lambda.Polygon_Import
  prefix       = var.prefix
}

module "Quandl_load_lambda" {
  source       = "../../module/load_lambda"
  load_lambda          = var.load_lambda.Quandl_DB_Load
  #lambda_execution_role = module.Quandl_import_lambda.lambda_execution_role
  import_function = module.Quandl_import_lambda.import_function
  prefix       = var.prefix
}

module "Norgate_load_lambda" {
  source       = "../../module/load_lambda"
  load_lambda          = var.load_lambda.Norgate_DB_Load
  #lambda_execution_role = module.Norgate_import_lambda.lambda_execution_role
  import_function = module.Norgate_import_lambda.import_function
  prefix       = var.prefix
}

module "Polygon_load_lambda" {
  source       = "../../module/load_lambda"
  load_lambda           = var.load_lambda.Polygon_DB_Load
  #lambda_execution_role = module.Polygon_import_lambda.lambda_execution_role
  import_function = module.Polygon_import_lambda.import_function
  prefix       = var.prefix
}

module "bastion_sg" {
  source = "../../module/bastion_sg"
  vpc_id = module.vpc.vpc_id
}