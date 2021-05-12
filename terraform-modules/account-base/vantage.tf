resource "aws_cloudformation_stack" "vantage" {
  name         = "vantage"
  template_url = "https://vantage-public.s3.amazonaws.com/x-account-role-create-1617047224.json"
  capabilities = ["CAPABILITY_IAM"]

  parameters = {
    VantageID          = var.vantage_id
    VantageDomain      = "https://console.vantage.sh"
    VantageIamRole     = "AROAZFRV7IUI4DENO75IR"
    VantageHandshakeID = var.vantage_handshake_id
    VantagePingbackArn = "arn:aws:sns:us-east-1:630399649041:cross-account-cloudformation-connector"
  }
}
