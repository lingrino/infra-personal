# Module - Account

This module does the very simple but important job of creating a new AWS account. Note that it can be very difficult to change account information after it is created and even harder to delete an account so use caution when calling this module.

Note that the root/owner account of the organization was created manually and then imported into this module after the fact.

## Usage

The below code is a simple way of calling the module.

```terraform
module "account" {
  source = "../path/to/module/account//"

  name  = "root"
  email = "example+root@gmail.com"

  tags = merge(
    { "Name" = var.name },
    var.tags
  )
}
```

## Creating an Account

When you create a new organization account in AWS a new role is also created, which by default is called `OrganizationAccountAccessRole`. Initially this is the only way to access the new account, however the role has no access restrictions and should be removed after the first terraform run that provisions more secure roles. For that reason, creating a new account is a somewhere manual process. Follow these steps.

1. Create a new file where you are calling the module called `account_ACCOUNTNAME.tf`

1. In that file add the following code

```hcl
module "account_ACCOUNTNAME" {
  source = "../../../../terraform-modules/account//"

  name  = "account_ACCOUNTNAME"
  email = "email+aws-account_ACCOUNTNAME@gmail.com"
  tags  = var.tags
}
```

1. Apply the terraform at this stage, a new account will be created

1. Now add the following blocks to the file

```hcl
provider "aws" {
  alias  = "ACCOUNTNAME"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::ACCOUNTID:role/OrganizationAccountAccessRole"
  }
}

[...]

module "account_ACCOUNTNAME_base" {
  source = "../../../../terraform-modules/account-base//"

  account_id   = module.account_ACCOUNTNAME.id
  account_name = module.account_ACCOUNTNAME.name

  account_id_auth   = AUTHACCOUNTID
  bucket_config_arn = data.terraform_remote_state.account_audit.outputs.bucket_config_arn

  tags = var.tags

  providers = {
    aws = aws.ACCOUNTNAME
  }
}
```

1. Now apply the terraform again, secure roles will be bootstrapped in the new account

1. Now change `OrganizationAccountAccessRole` in the `role_arn` provider section in the previous step to `Admin` or whatever role was provisioned.

1. Now log in as the new `Admin` user and delete the `OrganizationAccountAccessRole` that was created

1. You're all finished. If you ever lock yourself out of your account you may need to recover the root credentials in the created account, which you may want to do now instead.

## Updating an Account

You cannot update the `name` or `email` of the account with the API. If you need to update those fields then you must first recover the password of the root user and then sign in with the root account. You can then go to "My Account" and manually change the fields. Afterwards you can change the values in your terraform module and everything should continue to work

## Deleting an Account

Terraform destroy will not work on this module, organization accounts can not be terminated through the API. Follow the [Account Closure Docs][] to remove an account.

[Account Closure Docs]: https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_close.html
