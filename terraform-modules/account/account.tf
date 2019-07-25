resource "aws_organizations_account" "account" {
  name  = var.name
  email = var.email

  tags = merge(
    { "Name" = var.name },
    var.tags
  )

  provisioner "local-exec" {
    command = "sleep 120"
  }
}
