module "vpc" {
  source = "../../../../modules/aws/vpc"

  region         = "${ module.constants.aws_default_region }"
  vpc_cidr_block = "10.10.0.0/16"
  name_prefix    = "main"

  subnets_public_azs_to_cidrs = {
    us-east-2a = "10.10.0.0/22"
    us-east-2b = "10.10.4.0/22"
    us-east-2c = "10.10.8.0/22"
  }

  subnets_private_general_azs_to_cidrs = {
    us-east-2a = "10.10.32.0/22"
    us-east-2b = "10.10.36.0/22"
    us-east-2c = "10.10.40.0/22"
  }

  subnets_private_data_azs_to_cidrs = {
    us-east-2a = "10.10.64.0/22"
    us-east-2b = "10.10.68.0/22"
    us-east-2c = "10.10.72.0/22"
  }

  tags = {}
}
