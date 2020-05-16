output "sg_inter_id" {
  description = "The ID of the security group that can be attached to allow bastion communication"
  value       = aws_security_group.bastion_inter.id
}
