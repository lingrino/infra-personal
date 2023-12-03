resource "tfe_organization" "org" {
  name  = "lingrino"
  email = "sean@lingrino.com"

  collaborator_auth_policy = "two_factor_mandatory"

  cost_estimation_enabled                                 = true
  send_passing_statuses_for_untriggered_speculative_plans = true
}

resource "tfe_organization_membership" "lingrino" {
  organization = tfe_organization.org.name
  email        = "sean@lingrino.com"
}
