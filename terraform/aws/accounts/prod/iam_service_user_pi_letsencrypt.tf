# resource "aws_iam_user" "pi_letsencrypt" {
#   name = "pi-letsencrypt"
#   path = "/service/"

#   force_destroy = true

#   tags = merge(
#     { "Name" = "pi-letsencrypt" },
#     { "description" = "Used by raspberry pi to create letsencrypt certificates" },
#     var.tags
#   )
# }

# resource "aws_iam_access_key" "pi_letsencrypt" {
#   user   = aws_iam_user.pi_letsencrypt.name
#   status = "Active"
# }

# resource "aws_iam_group" "letsencrypt_lingrino_dev" {
#   name = "letsencrypt-lingrino-dev"
# }

# resource "aws_iam_group_membership" "letsencrypt_lingrino_dev" {
#   name  = "letsencrypt-lingrino-dev-members"
#   group = aws_iam_group.letsencrypt_lingrino_dev.name

#   users = [
#     aws_iam_user.pi_letsencrypt.name,
#   ]
# }

# resource "aws_iam_policy_attachment" "letsencrypt_lingrino_dev" {
#   name       = "letsencrypt-lingrino-dev-policy-attachments"
#   policy_arn = aws_iam_policy.letsencrypt_lingrino_dev.arn
#   groups     = [aws_iam_group.letsencrypt_lingrino_dev.name]
# }

# resource "aws_iam_policy" "letsencrypt_lingrino_dev" {
#   name        = "letsencrypt-lingrino-dev"
#   description = "Permissions for letsencrypt clients to create certificates for lingrino.dev"
#   policy      = data.aws_iam_policy_document.letsencrypt_lingrino_dev.json
# }

# data "aws_iam_policy_document" "letsencrypt_lingrino_dev" {
#   statement {
#     sid    = "AllowDiscoverZone"
#     effect = "Allow"

#     actions = [
#       "route53:ListHostedZones",
#       "route53:ListHostedZonesByName",
#     ]

#     resources = ["*"]
#   }

#   statement {
#     sid    = "AllowDiscoverChanges"
#     effect = "Allow"

#     actions = [
#       "route53:GetChange",
#     ]

#     resources = [
#       "arn:aws:route53:::change/*",
#     ]
#   }

#   statement {
#     sid    = "AllowUpdateRecords"
#     effect = "Allow"

#     actions = [
#       "route53:ListResourceRecordSets",
#       "route53:ChangeResourceRecordSets",
#     ]

#     resources = ["arn:aws:route53:::hostedzone/${data.aws_route53_zone.lingrino_dev.zone_id}"]
#   }
# }
