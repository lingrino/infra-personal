# Terraform - Organization

This repo contains the terraform to configure our AWS Organization and every account in our organization. This code should be lightweight and well protected as it has complete control over all of our AWS accounts.

## What Belongs in this Repo

Nothing in this repo should manage actual resources in actual AWS accounts. This repo is inteneded only to manage the AWS organization itself, and while technically those "resources" live in the account of the organization owner we consider them to be separate from that owner account.

Really this repo is only for three things:

1. Managing organization features
1. Managing organization policies
1. Managing organization accounts
