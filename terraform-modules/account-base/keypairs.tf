resource "aws_key_pair" "main" {
  key_name_prefix = "main-"
  public_key      = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOcnI3dvKaMOmOG7/PexPX1gCpR+EFdH4oj7zIr1bhVG sean@lingrino.com"

  tags = merge(
    { "Name" = "main" },
    { "description" = "primary keypair for the account" },
    var.tags
  )
}

output "keypair_main_name" {
  description = "The name of the main ssh keypair"
  value       = aws_key_pair.main.key_name
}
