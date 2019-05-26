module "atlantis" {
  source = "../../terraform-modules/heroku-app//"

  name_prefix = "atlantis"

  dns_names_to_zone_names = {
    "atlantis.lingrino.com" = "lingrino.com"
  }

  heroku_app_name   = "lingrino-atlantis"
  heroku_buildpacks = ["heroku/go"]
  heroku_app_domain = "https://lingrino-atlantis.herokuapp.com/"

  heroku_env_vars = {
    "foo" = "bar"
  }

  healthcheck_sns_arn = data.terraform_remote_state.account_audit.outputs.sns_alarm_high_priority_arn
  bucket_logs_domain  = data.terraform_remote_state.account_audit.outputs.bucket_logs_cloudfront_domain

  tags = var.tags
}
