# https://docs.aws.amazon.com/general/latest/gr/rande.html
output "hosted_zone_id_cloudfront" {
  value = "Z2FDTNDATAQYW2"
}

output "hosted_zone_ids_s3" {
  value = {
    us-east-1 = "Z3AQBSTGFYJSTF"
    us-east-2 = "Z2O1EMRO9K5GLX"
  }
}

output "hosted_zone_ids_alb" {
  value = {
    us-east-1 = "Z35SXDOTRQ7X7K"
    us-east-2 = "Z3AADJGX6KTTL2"
  }
}

output "hosted_zone_ids_nlb" {
  value = {
    us-east-1 = "Z26RNL4JYFTOTI"
    us-east-2 = "ZLMOA37VPKANP"
  }
}
