resource "aws_organizations_account" "account" {
  name  = var.name
  email = var.email

  provisioner "local-exec" {
    command = "sleep 120"
  }
}
