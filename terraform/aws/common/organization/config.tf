module "aws_config_rules" {
  source = "../config-org-rules//"

  tags = merge(
    { "service" = "config" },
    var.tags
  )
}
