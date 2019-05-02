# Module - Account

This module does the very simple but important job of creating a new AWS account.
Note that it can be very difficult to change account information after it is created
and even harder to delete an account so use caution when calling this module.

## Usage

The below code is a simple way of calling the module.

```terraform
module "account" {
  source = "../path/to/module/account//"

  name = "root"
  email = example+root@gmail.com
}
```

## Deleting an Account

Terraform destroy will not work on this module, organization accounts can not be
terminated through the API. Follow the [Account Closure Docs][] to remove an account.

[Account Closure Docs]: https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_accounts_close.html
