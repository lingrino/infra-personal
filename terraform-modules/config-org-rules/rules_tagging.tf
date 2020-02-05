#####################################
### Tagging Policy                ###
#####################################
resource "aws_config_organization_managed_rule" "tagging_policy" {
  name        = "tagging_policy"
  description = "Noncompliant when a resource does not meet the tagging policy"

  rule_identifier = "REQUIRED_TAGS"

  input_parameters = <<POLICY
{
  "tag1Key": "Name",
  "tag2Key": "service"
}
POLICY
}
