module "aws_config_rules" {
  source = "../config-rules//"

  tags = merge(
    { "service" = "config" },
    var.tags
  )
}
