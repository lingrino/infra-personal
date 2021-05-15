# Module - Account Base

This module configures all of the *base* resources in an account. These are resources that *every* account in the organization should have, without exception. For example, here we create predefined roles that can be assumed, password policies, and the account alias.

## Usage

The below code is a simple way of calling the module, along with my [account module][]. Note that in order for the below code to work you first have to apply **only** the `account` module and then add in the aws provider and the `account-base` module.

```terraform
provider "aws" {
  alias  = "prod"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::${ module.account_prod.id }:role/OrganizationAccountAccessRole"
  }

  default_tags {
    terraform = true
  }
}

module "account_prod" {
  source = "../../../../terraform-modules/account//"

  name  = "prod"
  email = "example+aws-prod@gmail.com"
}

module "account_prod_base" {
  source = "../../../../terraform-modules/account-base//"

  account_id   = module.account_prod.id
  account_name = module.account_prod.name

  account_id_auth   = module.account_auth.id
  bucket_config_arn = data.terraform_remote_state.account_prod.bucket_config_arn

  tags = var.tags

  providers {
    aws = aws.prod
  }
}
```

## What Belongs in this Module

The only resources that belong in this account are ones that will be created in every account in the organization. There should be no conditional creation of resources in this module. This is a great module to put base account resources that are required for initial access and organization.

## What about AWS Config Rules

This would be a great module to set up AWS config rules. However, rules in many accounts can become expensive. Check out my [config-rules module][] for examples of implementing a huge number of best-practices rules.

## Default VPCs

This module also runs a script that removes all default VPCs in all regions from the account. This requires that you have `bash`, `aws-cli`, and `jq` installed. You should not use default vpcs, my [vpc module][] will set things up in a nicer and more maintainable way.

[account module]: ../account/README.md
[config-rules module]: ../config-rules/README.md
[vpc module]: ../vpc/README.md
