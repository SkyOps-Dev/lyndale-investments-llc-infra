###GLOBAL_VARIABLE_START###
variable "aws_region" {
  default = "us-east-1"
}
variable "vpc" {}
variable "prefix" {}
variable "auto_scaling" {}
variable "security_group" {}

variable "rds" {}

variable "import_lambda" {}

variable "load_lambda" {}

variable "s3" {}