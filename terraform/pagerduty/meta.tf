#################################
### Providers                 ###
#################################
provider "pagerduty" {}

#################################
### Terraform                 ###
#################################
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "lingrino"

    workspaces {
      name = "pagerduty"
    }
  }

  required_providers {
    pagerduty = {
      source = "PagerDuty/pagerduty"
    }
  }
}
