resource "aws_config_configuration_aggregator" "lingrino" {
  name = "lingrino"

  account_aggregation_source {
    account_ids = data.terraform_remote_state.organization.outputs.account_ids
    all_regions = true
  }

  tags = {
    Name    = "lingrino"
    service = "config"
  }
}
