resource "digitalocean_ssh_key" "main" {
  name       = "main"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOcnI3dvKaMOmOG7/PexPX1gCpR+EFdH4oj7zIr1bhVG sean@lingrino.com"
}
