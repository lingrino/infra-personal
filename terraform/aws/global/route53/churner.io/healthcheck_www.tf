resource "aws_route53_health_check" "www" {
  reference_name = "churner_io_www"

  fqdn          = "www.${ var.bare_domain }"
  type          = "HTTPS"
  port          = 443
  resource_path = "/"

  failure_threshold = "5"
  request_interval  = "30"

  tags = "${ merge(
    map(
      "Name",
      "${ var.bare_domain }"
    ),
    module.constants.tags_default )
  }"
}
