# From https://docs.aws.amazon.com/IAM/latest/UserGuide/tutorial_users-self-manage-mfa-and-creds.html
resource "aws_iam_policy" "user_manage_self" {
  name        = "user-manage-self"
  description = "This policy allows users to manage their own passwords and MFA devices but nothing else unless they authenticate with MFA"
  path        = "/endusers/"
  policy      = "${ data.aws_iam_policy_document.user_manage_self_policy.json }"
}

data "aws_iam_policy_document" "user_manage_self_policy" {
  statement {
    sid    = "AllowAllUsersToListAccounts"
    effect = "Allow"

    actions = [
      "iam:ListAccountAliases",
      "iam:ListUsers",
      "iam:ListVirtualMFADevices",
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowIndividualUserToSeeAndManageOnlyTheirOwnAccountInformation"
    effect = "Allow"

    actions = [
      "iam:ChangePassword",
      "iam:CreateAccessKey",
      "iam:CreateLoginProfile",
      "iam:DeleteAccessKey",
      "iam:DeleteLoginProfile",
      "iam:GetLoginProfile",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
      "iam:UpdateLoginProfile",
      "iam:ListSigningCertificates",
      "iam:DeleteSigningCertificate",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate",
      "iam:ListSSHPublicKeys",
      "iam:GetSSHPublicKey",
      "iam:DeleteSSHPublicKey",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey",
    ]

    resources = ["arn:aws:iam::${ module.constants.aws_account_id }:user/$${ aws:username }"]
  }

  statement {
    sid     = "AllowIndividualUserToListOnlyTheirOwnMFA"
    effect  = "Allow"
    actions = ["iam:ListMFADevices"]

    resources = [
      "arn:aws:iam::${ module.constants.aws_account_id }:mfa/*",
      "arn:aws:iam::${ module.constants.aws_account_id }:user/$${ aws:username }",
    ]
  }

  statement {
    sid    = "AllowIndividualUserToManageTheirOwnMFA"
    effect = "Allow"

    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice",
    ]

    resources = [
      "arn:aws:iam::${ module.constants.aws_account_id }:user/$${ aws:username }",
      "arn:aws:iam::${ module.constants.aws_account_id }:mfa/$${ aws:username }",
    ]
  }

  statement {
    sid     = "AllowIndividualUserToDeactivateOnlyTheirOwnMFAOnlyWhenUsingMFA"
    effect  = "Allow"
    actions = ["iam:DeactivateMFADevice"]

    resources = [
      "arn:aws:iam::${ module.constants.aws_account_id }:user/$${ aws:username }",
      "arn:aws:iam::${ module.constants.aws_account_id }:mfa/$${ aws:username }",
    ]

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }

  statement {
    sid    = "BlockMostAccessUnlessSignedInWithMFA"
    effect = "Deny"

    not_actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
      "iam:ListVirtualMFADevices",
      "iam:EnableMFADevice",
      "iam:ResyncMFADevice",
      "iam:ListAccountAliases",
      "iam:ListUsers",
      "iam:ListSSHPublicKeys",
      "iam:ListAccessKeys",
      "iam:ListServiceSpecificCredentials",
      "iam:ListMFADevices",
      "iam:GetAccountSummary",
      "sts:GetSessionToken",
    ]

    resources = ["*"]

    condition {
      test     = "BoolIfExists"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["false"]
    }
  }
}
