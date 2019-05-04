# Module - Route53 Zone Delegation

This module helps you delegate a subdomain from one route53 zone that you own to another route53
zone that you own. Both zones must already exist. All this module does is create NS delegation
records in the zone doing the delegation equal to the root NS records of the zone being delegated.

## Usage

The below code is a simple way of calling the module.

```terraform
module "delegate_dev_example_com" {
  source = "../path/to/module/route53-zone-delegation//"

  zone_id = "${ module.zone_example_com.zone_id }"
  domain = "dev.example.com"
  nameservers = ["${ module.zone_dev_example_com.nameservers }]
}
```
