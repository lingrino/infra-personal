#################################
### Providers                 ###
#################################
provider "pagerduty" {}

#################################
### Terraform                 ###
#################################
terraform {
  cloud {
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
