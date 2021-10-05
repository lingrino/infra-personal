module "vpc" {
  source = "../../../../terraform-modules/vpc//"

  enable_nat = false

  name_prefix = "dev"
  cidr_block  = "10.10.0.0/16"

  azs = {
    "us-east-1a" = {
      "public" : "10.10.0.0/22",
      "private" : "10.10.32.0/20",
      "intra" : "10.10.144.0/22",
    }
    "us-east-1b" = {
      "public" : "10.10.4.0/22",
      "private" : "10.10.48.0/20",
      "intra" : "10.10.148.0/22",
    }
    "us-east-1c" = {
      "public" : "10.10.8.0/22"
      "private" : "10.10.64.0/20",
      "intra" : "10.10.152.0/22",
    }
    "us-east-1d" = {
      "public" : "10.10.12.0/22"
      "private" : "10.10.80.0/20",
      "intra" : "10.10.156.0/22",
    }
    "us-east-1e" = {
      "public" : "10.10.16.0/22"
      "private" : "10.10.96.0/20",
      "intra" : "10.10.160.0/22",
    }
  }

  tags = {
    default = "true"
  }
}
