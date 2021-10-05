module "vpc" {
  source = "../../../../terraform-modules/vpc//"

  enable_nat = false

  name_prefix = "dev"
  cidr_block  = "10.100.0.0/16"

  azs = {
    "us-east-1a" = {
      "public" : "10.100.0.0/22",
      "private" : "10.100.32.0/20",
      "intra" : "10.100.144.0/22",
    }
    "us-east-1b" = {
      "public" : "10.100.4.0/22",
      "private" : "10.100.48.0/20",
      "intra" : "10.100.148.0/22",
    }
    "us-east-1c" = {
      "public" : "10.100.8.0/22"
      "private" : "10.100.64.0/20",
      "intra" : "10.100.152.0/22",
    }
    "us-east-1d" = {
      "public" : "10.100.12.0/22"
      "private" : "10.100.80.0/20",
      "intra" : "10.100.156.0/22",
    }
    "us-east-1e" = {
      "public" : "10.100.16.0/22"
      "private" : "10.100.96.0/20",
      "intra" : "10.100.160.0/22",
    }
  }

  tags = {
    default = "true"
  }
}
