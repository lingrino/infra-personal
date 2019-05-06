
# Module - SES Domain

This module creates an SES sending domain and validates it with route53 DNS. The module will work
even when the account that owns the DNS zone and the account that needs the delegation are different
because the module takes explicitly passed providers.

## Usage

The below code is a simple way of calling the module to create an ses domain in the same account
that owns the route53 zone. Note that you still must pass providers explicitly.

```terraform
module "ses" {
  source = "../path/to/module/ses-domain//"

  domain_name = "example.com"

  providers {
    aws.dns  = "aws"
    aws.ses = "aws"
  }
}
```

This code is a simple way of calling the module to create an ses domain where the owner of the
route53 zones is in a different account than the owner of the ses domain.

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

module "ses" {
  source = "../path/to/module/ses-domain//"

  zone_name   = "example.com"
  domain_name = "dev.example.com"

  providers {
    aws.dns  = "aws.prod"
    aws.ses  = "aws.dev"
  }
}
```

## Provider Reasoning

You'll notice that even when you're making a cert in the same account as the DNS zone you must
explicitly pass the same provider to both `aws.dns` and `aws.ses` in the module. The benefit of this
is that the module works exactly the same for both same and cross account validations. The downside
is that sometimes you have to be more explicit than terraform usually requires.
