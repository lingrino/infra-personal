module "aws_config_rules" {
  source = "../config-rules//"

  tags = var.tags
}
