# Module - Fastmail

This module creates the records necessary to verify the domain with fastmail.

## Usage

The below code is a simple way of calling the module.

```terraform
module "fastmail" {
  source = "../path/to/module/fastmail//"

  zone_name   = "example.com"
  domain_name = "dev.example.com"

  enable_login_portal = true
}
```
