data "digitalocean_kubernetes_versions" "main" {}

resource "digitalocean_kubernetes_cluster" "main" {
  name          = "main"
  region        = "sfo3"
  version       = data.digitalocean_kubernetes_versions.main.latest_version
  vpc_uuid      = digitalocean_vpc.main_sfo3.id
  auto_upgrade  = true
  surge_upgrade = true

  node_pool {
    name       = "main"
    size       = "s-1vcpu-2gb"
    node_count = 3

    tags = [
      digitalocean_tag.prod.name,
      digitalocean_tag.terraform.name,
    ]
  }

  tags = [
    digitalocean_tag.prod.name,
    digitalocean_tag.terraform.name,
  ]
}
