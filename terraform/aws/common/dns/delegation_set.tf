resource "aws_route53_delegation_set" "lingrino" {
  reference_name = "lingrino"
}

output "lingrino_delegation_set_id" {
  description = "The ID of the lingrino delegation set"
  value       = "${ aws_route53_delegation_set.lingrino.id }"
}

output "lingrino_delegation_set_nameservers" {
  description = "The nameservers for the lingrino delegation set"
  value       = "${ aws_route53_delegation_set.lingrino.name_servers }"
}
