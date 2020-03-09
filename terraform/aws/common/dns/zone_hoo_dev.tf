module "zone_hoo_dev" {
  source = "../../../../terraform-modules/route53-zone-public//"

  domain            = "hoo.dev"
  delegation_set_id = aws_route53_delegation_set.lingrino_prod.id

  enable_gsuite        = true
  keybase_record_value = "keybase-site-verification=mXA2oi_ATtgTx1BqzRWOgswAVqXRoSK0LF1CSyoD3zg"
  gsuite_dkim_value    = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA8i7T0rD8MidU+LlaEA/Z0Yla1yr2D63ugjjFKVtOov3SjwXEkjd8lEN4IJR2CBATrrazo9joK8O9RQuOPfQmS9hiQ8ERawxkWFQkKE6N3cf/n3Ua9jC54NJc2/46EP7hUpPeXBIlFq40tasA09pggQbePRtf4fWXEJFI4J/Z7X0UxHlIDBSYC/Xe951pK0QHXxImIzjldSOvJag19NR6Sw6cKINwnERwA3IMhffukIkgKv3nLUwaTs8WVHnc9IbpY8rGObP63qVES73a3c7jR3sG23wKTJo7peDrhm/LOe2+NzSxtYd0S7fbQhfIYkxQnXNH9E65zKamuAjnb7btnQIDAQAB"
  google_site_verifications = [
    "google-site-verification=jeM663GFEWhSHAUagRqbo5DY_E33pc6WetyK_5hLBPE",
    "google-site-verification=IlVlYTBjP_nWq4q1G_AgW5AjNSLQ9MNUPoH-uLcZCW8"
  ]

  ses_sns_arn = data.terraform_remote_state.account_audit.outputs.sns_alarm_low_priority_arn

  tags = var.tags

  providers = {
    aws = aws.prod
  }
}
