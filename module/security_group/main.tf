resource "aws_security_group" "SG" {
  vpc_id = var.vpc_id

  egress {
    from_port   = var.security_group.outbound_all_port
    to_port     = var.security_group.outbound_all_port
    protocol    = var.security_group.all_protocol
    cidr_blocks = var.security_group.cidr_allow_all
  }
  ingress {
    from_port   = var.security_group.http_port
    to_port     = var.security_group.http_port
    protocol    = var.security_group.tcp_protocol
    cidr_blocks = var.security_group.cidr_allow_all

  }
  tags = {
    Name = "${var.prefix.environment}-${var.prefix.name}-SG"
  }
}