module "vpc" {
  source = "../../../../modules/aws/vpc"

  name_prefix    = "main"
  region         = "${ module.constants.aws_default_region }"
  vpc_cidr_block = "10.10.0.0/16"

  azs = [
    "us-east-2a",
    "us-east-2b",
    "us-east-2c",
  ]

  tags = {}
}
