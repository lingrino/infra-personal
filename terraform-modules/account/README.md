# Module - Account

This module does the very simple but important job of creating a new AWS account. Note that it can
be very difficult to change account information after it is created and even harder to delete an
account so use caution when calling this module.

Note that the root/owner account of the organization was created manually and then imported into
this module after the fact.

## Usage

The below code is a simple way of calling the module.

```terraform
module "account" {
  source = "../path/to/module/account//"

  name = "root"
  email = example+root@gmail.com
}
```

## Updating an Account

You cannot update the `name` or `email` of the account with the API. If you need to update those
fields then you must first recover the password of the root user and then sign in with the root
account. You can then go to "My Account" and manually change the fields. Afterwards you can change
the values in your terraform module and everything should continue to work

## Deleting an Account

Terraform destroy will not work on this module, organization accounts can not be terminated through
the API. Follow the [Account Closure Docs][] to remove an account.

[Account Closure Docs]:
https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_close.html
