resource "aws_organizations_account" "account" {
  name  = var.name
  email = var.email

  tags = merge(var.tags, {
    Name = var.name
  })

  provisioner "local-exec" {
    command = "sleep 120"
  }
}
