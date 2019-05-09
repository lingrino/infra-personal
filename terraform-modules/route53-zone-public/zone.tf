resource "aws_route53_zone" "zone" {
  name    = var.domain
  comment = "Zone for ${var.domain}. Managed by Terraform."

  delegation_set_id = var.delegation_set_id

  tags = merge(
    {"Name" = var.domain},
    var.tags
  )
}
