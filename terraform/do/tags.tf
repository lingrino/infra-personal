resource "digitalocean_tag" "dev" {
  name = "dev"
}

resource "digitalocean_tag" "prod" {
  name = "prod"
}

resource "digitalocean_tag" "terraform" {
  name = "terraform"
}
