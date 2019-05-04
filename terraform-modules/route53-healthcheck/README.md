# Module - Route53 Healthcheck

This module creates a healhcheck against a list of domains using route53 and CloudWath metrics. The
module requires that you already have an SNS topic set up that can receive all of your ok, alarm,
and insufficient actions. The defaults work well for reliable static sites deployed to cloudfront
but can be modified but other use cases.

## Usage

The below code is a simple way of calling the module.

```terraform
module "check" {
  source = "../path/to/module/route53-healthcheck//"

  domains = ["example.com", "example.org", "prod.example.com"]
  sns_arn = "arn:aws:sns:us-east-1:000000000000:sns-name"

  tags = "${ var.tags }"
}
```
