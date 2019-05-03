# Terraform - DNS

This terraform contains configuration for all of my DNS zones. The provider for this repo is my
`lingrino-prod` account. It is useful to separate DNS configurations from other resources because
DNS takes an unusually long amount of time to plan and apply and is also especially sensitive.
