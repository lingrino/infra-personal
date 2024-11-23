resource "tfe_organization" "org" {
  name  = "lingrino"
  email = "sean@lingren.com"

  collaborator_auth_policy = "two_factor_mandatory"

  cost_estimation_enabled                                 = true
  speculative_plan_management_enabled                     = true
  send_passing_statuses_for_untriggered_speculative_plans = true
}

resource "tfe_organization_default_settings" "org" {
  organization           = tfe_organization.org.name
  default_execution_mode = "remote"
}

resource "tfe_organization_membership" "lingrino" {
  organization = tfe_organization.org.name
  email        = "sean@lingren.com"
}
