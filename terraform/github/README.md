# Terraform - GitHub

This terraform manages all of my GitHub repos and other configurations.

## Terraform GitHub Provider

Note that the terraform GitHub provider does not actually support creating repos for an individual user and if you try to create a new repo directly through this module it will fail. However I've found that you can create the repo manually and then import it so that terraform can manage the repo without issues.
