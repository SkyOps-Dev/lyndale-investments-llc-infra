prefix = {
  name        = "lyndale"
  environment = "dev"
}

aws_region = "us-east-1"

s3 = {
  name = "S3_Bucket6543"
}

vpc = {
  vpc_cidr_block  = "10.0.0.0/16"
  public_subnets  = ["10.0.0.0/24", "10.0.8.0/24"]
  private_subnets = ["10.0.40.0/24", "10.0.48.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true
}
rds = {
  identifier                   = "dev-lyndale"
  allocated_storage            = "20"
  storage_type                 = "gp3"
  engine                       = "postgres"
  engine_version               = "16.2"
  instance_class               = "db.t3.micro"
  db_name                      = "devlyndale162"
  username                     = "secret_user"
  backup_retention_period      = "7"
  backup_window                = "00:00-00:30"
  skip_final_snapshot          = true
  publicly_accessible          = false
  multi_az                     = false
  auto_minor_version_upgrade   = true
  performance_insights_enabled = true
  allow_major_version_upgrade  = true
  apply_immediately            = true
}
import_lambda = {
  Quandl_Import= {
    name = "Quandl_Import"
  },
  Norgate_Import = {
    name = "Norgate_Import"
  },
  Polygon_Import = {
    name = "Polygon_Import"
  }
}
load_lambda = {
  Quandl_DB_Load = {
    name = "Quandl_DB_Load"
  },
  Norgate_DB_Load = {
    name = "Norgate_DB_Load"
  },
  Polygon_DB_Load = {
    name = "Polygon_DB_Load"
  }
}