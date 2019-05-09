resource "aws_route53_delegation_set" "lingrino_prod" {
  provider       = aws.prod
  reference_name = "lingrino"
}

resource "aws_route53_delegation_set" "lingrino_dev" {
  provider       = aws.dev
  reference_name = "lingrino-dev"
}

output "lingrino_prod_delegation_set_id" {
  description = "The ID of the prod lingrino delegation set"
  value       = aws_route53_delegation_set.lingrino_prod.id
}

output "lingrino_prod_delegation_set_nameservers" {
  description = "The nameservers for the prod lingrino delegation set"
  value       = aws_route53_delegation_set.lingrino_prod.name_servers
}

output "lingrino_dev_delegation_set_id" {
  description = "The ID of the dev lingrino delegation set"
  value       = aws_route53_delegation_set.lingrino_dev.id
}

output "lingrino_dev_delegation_set_nameservers" {
  description = "The nameservers for the dev lingrino delegation set"
  value       = aws_route53_delegation_set.lingrino_dev.name_servers
}
