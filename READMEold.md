# Personal Infrastructure

Terraform for setting up all my personal infrastructure. Notice that the terraform is creating its own state
bucket and users/roles to administrate itself. To bootstrap this was done manually and then imported
into state. The amount of complexity in this setup is overkill for my actual personal use of AWS, but
it will allow for scale in the future and is a good way to test best practices.

## Security

I take security very seriously. When done properly, this project should not present a secutiy risk
to my infrastructure. However, no one is perfect. If you notice a vulnerability please email me at
security@srlingren.com

## Organization

```console
# Templates
terraform/provider/...
terraform/modules/provider/...

# AWS Provider
terraform/aws/region/service
terraform/aws/region/service/vpc
terraform/modules/aws/service/module_name
terraform/modules/aws/s3/generic_bucket
terraform/aws/global/iam
terraform/aws/us-east-2/kms
terraform/aws/us-east-2/ec2/main

# Github Provider
terraform/github/repos/repo_name
```

## Constants Module

Holds static information that cannot be pulled from terraform.
Account ID is hardcoded here, depite being available in [terraform](https://www.terraform.io/docs/providers/aws/d/caller_identity.html)
because it safeguards applying against the wrong account.

## TODO

- trusted advisor emails
- aws config
