resource "aws_organizations_organization" "org" {
  feature_set = "ALL"

  aws_service_access_principals = [
    "aws-artifact-account-sync.amazonaws.com",
    "account.amazonaws.com",
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "config-multiaccountsetup.amazonaws.com",
    "iam.amazonaws.com",
    "ram.amazonaws.com",
    "sso.amazonaws.com",
  ]
}

resource "aws_iam_organizations_features" "org" {
  enabled_features = [
    "RootCredentialsManagement",
    "RootSessions"
  ]
}
