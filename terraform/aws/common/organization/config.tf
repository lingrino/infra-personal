module "aws_config_rules" {
  source = "../../../../terraform-modules/config-org-rules//"

  tags = merge(
    { "service" = "config" },
    var.tags
  )
}
