output "security_group" {
  value = var.security_group
}

output "security_group_id" {
  value = aws_security_group.SG.id
}