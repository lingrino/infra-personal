resource "aws_config_configuration_aggregator" "lingrino" {
  name = "lingrino"

  organization_aggregation_source {
    all_regions = true
    role_arn    = "${ aws_iam_role.config_lingrino_aggregator.arn }"
  }

  depends_on = ["aws_iam_role_policy_attachment.config_lingrino_aggregator_service"]
}

resource "aws_iam_role" "config_lingrino_aggregator" {
  name_prefix = "config-lingrino-aggregator-"
  description = "Allow AWS Config to get information about the AWS Organization"

  assume_role_policy = "${ data.aws_iam_policy_document.arp_config_lingrino_aggregator.json }"

  tags = "${ merge(
    map("Name", "config-lingrino-aggregator"),
    map("description", "Allow AWS Config to get information about the AWS Organization"),
    var.tags
  )}"
}

resource "aws_iam_role_policy_attachment" "config_lingrino_aggregator_service" {
  role       = "${ aws_iam_role.config_lingrino_aggregator.name }"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRoleForOrganizations"
}

data "aws_iam_policy_document" "arp_config_lingrino_aggregator" {
  statement {
    sid    = "AllowConfigAssume"
    effect = "Allow"

    principals = {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
    ]
  }
}
