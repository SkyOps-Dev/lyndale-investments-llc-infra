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

auto_scaling = { Daily_Scan_EC2 = {
  name                        = "Daily Scan EC2's"
  prefix                      = ""
  desired_capacity            = "2"
  max_size                    = "2"
  min_size                    = "2"
  key_name                    = ""
  resource_type               = "instance"
  health_check_type           = "EC2"
  instance_type               = "t2.micro"
  cooldown                    = "300"
  adjustment_type             = "ChangeInCapacity"
  resource_type               = "instance"
  enabled                     = true
  scale_up_adjustment         = 1
  scale_down_adjustment       = 1
  adjustment_type             = "ChangeInCapacity"
  name_autoscaling_group      = "Daily_Scan_autoscaling_group"
  version                     = "$Latest"
  as_up_policy_name           = "Daily_Scan_scale_up_policy"
  as_down_policy_name         = "Daily_Scan_scale_down_policy"
  user_data                   = "../../module/autoscaling/daily_scan.sh"
  },

  Factor_EC2 = {
    name                        = "Factor_EC2's"
    desired_capacity            = "2"
    max_size                    = "2"
    min_size                    = "2"
    key_name                    = ""
    resource_type               = "instance"
    health_check_type           = "EC2"
    instance_type               = "t2.micro"
    cooldown                    = "300"
    adjustment_type             = "ChangeInCapacity"
    resource_type               = "instance"
    enabled                     = true
    scale_up_adjustment         = 1
    scale_down_adjustment       = 1
    adjustment_type             = "ChangeInCapacity"
    name_autoscaling_group      = "Factor_autoscaling_group"
    version                     = "$Latest"
    as_up_policy_name           = "Factor_scale_up_policy"
    as_down_policy_name         = "Factor_scale_down_policy"
    user_data                   = "../../module/autoscaling/factor.sh"
  },
  Trade_Staging_EC2 = {
    name                        = "Trade Staging EC2's"
    desired_capacity            = "2"
    max_size                    = "2"
    min_size                    = "2"
    key_name                    = ""
    resource_type               = "instance"
    health_check_type           = "EC2"
    instance_type               = "t2.micro"
    cooldown                    = "300"
    adjustment_type             = "ChangeInCapacity"
    resource_type               = "instance"
    enabled                     = true
    scale_up_adjustment         = 1
    scale_down_adjustment       = 1
    adjustment_type             = "ChangeInCapacity"
    name_autoscaling_group      = "Trade_Staging_autoscaling_group"
    version                     = "$Latest"
    as_up_policy_name           = "Trade_Staging_scale_up_policy"
    as_down_policy_name         = "Trade_Staging_scale_down_policy"
    user_data                   = "../../module/autoscaling//trade_staging.sh"
  }
}

security_group = {
  http_port         = "80"
  ssh_port          = "22"
  outbound_all_port = "0"
  tcp_protocol      = "TCP"
  all_protocol      = "-1"
  cidr_allow_all    = ["0.0.0.0/0"]
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