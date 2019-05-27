# Module - ACM Certificate

This module creates an ACM certificate and validates it with route53 DNS. The module will work even
when the account that owns the DNS zones and the account that needs the certificate are different
because the module takes explicitly passed providers.

Another benefit of this module is that it can create certificates for multiple route53 zones. For
example, you can use this module to make a certificate that is valid for `foo.example.com` and
`foo.example.net`.

## Usage

The below code is a simple way of calling the module to create a certificate in the same account
that owns the route53 zone. Note that you still must pass providers explicitly.

```terraform
module "cert" {
  source = "../path/to/module/acm-certificate//"

  dns_names_to_zone_names {
    "example.com"     = "example.com"
    "*.example.com"   = "example.com"
    "foo.example.org" = "example.org"
  }

  tags = var.tags

  providers {
    aws.dns  = aws
    aws.cert = aws
  }
}
```

This code is a simple way of calling the module to create a certificate where the owner of the
route53 zones is in a different account than the owner of the certificate.

```terraform
provider "aws" {
  alias  = "prod"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::000000000:role/Admin"
  }
}

provider "aws" {
  alias  = "dev"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::111111111:role/Admin"
  }
}

module "cert" {
  source = "../path/to/module/acm-certificate//"

  dns_names_to_zone_names {
    "example.com"     = "example.com"
    "*.example.com"   = "example.com"
    "foo.example.org" = "example.org"
  }

  tags = var.tags

  providers {
    aws.dns  = aws.prod
    aws.cert = aws.dev
  }
}
```

## Why Do We Need a Map of DNS Names to Zone Names

The primary input in this module is a map variable called `dns_names_to_zone_names`. The reason this
is necessary is because it's otherwise possible (using terraform data sources) to know which route53
zone to use for each record. For example if I have two zones, one that is `example.com` and one that
is `foo.example.com` and I want to make a cert for `bar.foo.example.com` I could create that in
either zone and so the user must be explicit in which zone they wish to use. The map should be such
that the *key* is the fqdn to create the cert for and the *value* is the name of the route53 zone in
which to create that cert validation record.

## Provider Reasoning

You'll notice that even when you're making a cert in the same account as the DNS zone you must
explicitly pass the same provider to both `aws.cert` and `aws.dns` in the module. The benefit of
this is that the module works exactly the same for both same and cross account certs. The downside
is that sometimes you have to be more explicit than terraform usually requires.
