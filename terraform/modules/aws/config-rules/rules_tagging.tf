#####################################
### Tagging Policy                ###
#####################################
resource "aws_config_config_rule" "tagging_policy" {
  name        = "tagging_policy"
  description = "Noncompliant when a resource does not meet the tagging policy"

  source {
    owner             = "AWS"
    source_identifier = "REQUIRED_TAGS"
  }

  input_parameters = <<POLICY
{
  "tag1Key": "Name",
  "tag2Key": "service",
  "tag3Key": "terraform",
  "tag3Value": "true"
}
POLICY
}
