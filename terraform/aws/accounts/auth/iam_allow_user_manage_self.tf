resource "aws_iam_group_membership" "allow_user_manage_self" {
  name  = "allow-user-manage-self-members"
  group = "${ aws_iam_group.allow_user_manage_self.name }"

  users = [
    "${ aws_iam_user.srlingren_gmail_com.name }",
  ]
}

resource "aws_iam_group" "allow_user_manage_self" {
  name = "allow-user-manage-self"
}

resource "aws_iam_policy_attachment" "allow_user_manage_self" {
  name       = "allow-user-manage-self-policy-attachments"
  policy_arn = "${ aws_iam_policy.allow_user_manage_self.arn }"
  groups     = ["${ aws_iam_group.allow_user_manage_self.name }"]
}

# From https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_aws_my-sec-creds-self-manage.html
resource "aws_iam_policy" "allow_user_manage_self" {
  name        = "allow-user-manage-self"
  description = "This policy allows users to manage their own passwords and MFA devices but nothing else unless they authenticate with MFA"
  policy      = "${ data.aws_iam_policy_document.allow_user_manage_self.json }"
}

data "aws_iam_policy_document" "allow_user_manage_self" {
  statement {
    sid    = "AllowViewAccountInfo"
    effect = "Allow"

    actions = [
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
      "iam:ListUsers",
      "iam:ListVirtualMFADevices",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AllowManageOwnPasswords"
    effect = "Allow"

    actions = [
      "iam:ChangePassword",
      "iam:CreateLoginProfile",
      "iam:DeleteLoginProfile",
      "iam:GetLoginProfile",
      "iam:GetUser",
      "iam:UpdateLoginProfile",
    ]

    resources = ["arn:aws:iam::${ var.account_id }:user/$${ aws:username }"]
  }

  statement {
    sid    = "AllowManageOwnAccessKeys"
    effect = "Allow"

    actions = [
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
    ]

    resources = ["arn:aws:iam::${ var.account_id }:user/$${ aws:username }"]
  }

  statement {
    sid    = "AllowManageOwnSigningCertificates"
    effect = "Allow"

    actions = [
      "iam:DeleteSigningCertificate",
      "iam:ListSigningCertificates",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate",
    ]

    resources = ["arn:aws:iam::${ var.account_id }:user/$${ aws:username }"]
  }

  statement {
    sid    = "AllowManageOwnSSHPublicKeys"
    effect = "Allow"

    actions = [
      "iam:DeleteSSHPublicKey",
      "iam:GetSSHPublicKey",
      "iam:ListSSHPublicKeys",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey",
    ]

    resources = ["arn:aws:iam::${ var.account_id }:user/$${ aws:username }"]
  }

  statement {
    sid    = "AllowManageOwnGitCredentials"
    effect = "Allow"

    actions = [
      "iam:CreateServiceSpecificCredential",
      "iam:DeleteServiceSpecificCredential",
      "iam:ListServiceSpecificCredentials",
      "iam:ResetServiceSpecificCredential",
      "iam:UpdateServiceSpecificCredential",
    ]

    resources = ["arn:aws:iam::${ var.account_id }:user/$${ aws:username }"]
  }

  statement {
    sid    = "AllowManageOwnVirtualMFADevice"
    effect = "Allow"

    actions = [
      "iam:CreateVirtualMFADevice",
      "iam:DeleteVirtualMFADevice",
    ]

    resources = ["arn:aws:iam::${ var.account_id }:mfa/$${ aws:username }"]
  }

  statement {
    sid    = "AllowManageOwnUserMFA"
    effect = "Allow"

    actions = [
      "iam:DeactivateMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ResyncMFADevice",
    ]

    resources = ["arn:aws:iam::${ var.account_id }:user/$${ aws:username }"]
  }

  statement {
    sid    = "DenyAllExceptListedIfNoMFA"
    effect = "Deny"

    not_actions = [
      "iam:ChangePassword",
      "iam:CreateLoginProfile",
      "iam:CreateVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:GetUser",
      "iam:ListMFADevices",
      "iam:ListUsers",
      "iam:ListVirtualMFADevices",
      "iam:ResyncMFADevice",
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
