resource "aws_launch_template" "lt" {
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.auto_scaling.instance_type
  key_name      = var.auto_scaling.key_name
  monitoring {
    enabled = var.auto_scaling.enabled
  }
  network_interfaces {
    security_groups = [var.security_group_id]
  }
  tag_specifications {
    resource_type = var.auto_scaling.resource_type
    tags = {
      Name = "${var.prefix.environment}-${var.prefix.name}-${var.auto_scaling.name}"
    }
  }
  user_data = filebase64(var.auto_scaling.user_data)
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name                = var.auto_scaling.name_autoscaling_group
  desired_capacity    = var.auto_scaling.desired_capacity
  max_size            = var.auto_scaling.max_size
  min_size            = var.auto_scaling.min_size
  health_check_type   = var.auto_scaling.health_check_type
  vpc_zone_identifier = var.private_subnet_ids[*]
  launch_template {
    id      = aws_launch_template.lt.id
    version = var.auto_scaling.version
  }
}

resource "aws_autoscaling_policy" "instance_up" {
  name                   = var.auto_scaling. as_up_policy_name
  scaling_adjustment     = var.auto_scaling.scale_up_adjustment
  adjustment_type        = var.auto_scaling.adjustment_type
  cooldown               = var.auto_scaling.cooldown
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
}

resource "aws_autoscaling_policy" "instance_down" {
  name                   = "${var.prefix.environment}-${var.prefix.name}-${var.auto_scaling.as_down_policy_name}"                  
  scaling_adjustment     = var.auto_scaling.scale_down_adjustment
  adjustment_type        = var.auto_scaling.adjustment_type
  cooldown               = var.auto_scaling.cooldown
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
}

/*
resource "aws_autoscaling_attachment" "autoscaling_attachment" {
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.id
  lb_target_group_arn    = var.target_group_arn
}*/