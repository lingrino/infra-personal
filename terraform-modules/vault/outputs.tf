output "alb_dns_name" {
  description = "The DNS name of the created ALB"
  value       = aws_lb.vault.dns_name
}

output "alb_zone_id" {
  description = "The zone ID of the created ALB"
  value       = aws_lb.vault.zone_id
}
