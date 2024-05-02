locals {
  subnet_ids = var.prefix.environment == "dev" ? module.vpc.public_subnet_ids : module.vpc.private_subnet_ids

  secrets = []

  environment = [
    {
      name  = "AWS_REGION"
      value = "${var.aws_region}"
    },
  ]
}