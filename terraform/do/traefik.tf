locals {
  cloudflared_version     = "2021.1.5" # https://github.com/cloudflare/cloudflared/releases
  cloudflared_tunnel_uuid = "4f6493bb-48d1-479a-895a-5869ee2cb09b"
}

resource "kubernetes_namespace" "traefik" {
  metadata {
    generate_name = "traefik-"
  }
}

resource "kubernetes_config_map" "cloudflared" {
  metadata {
    generate_name = "cloudflared-"
    namespace     = kubernetes_namespace.traefik.id
  }

  data = {
    "config.yml" = templatefile("files/cloudflared.yaml", {
      cloudflared_tunnel_uuid = local.cloudflared_tunnel_uuid
    })
  }
}

resource "helm_release" "traefik" {
  repository = "https://helm.traefik.io/traefik"
  chart      = "traefik"

  name        = "traefik"
  description = "traefik"
  namespace   = kubernetes_namespace.traefik.id

  cleanup_on_fail   = true
  dependency_update = true

  values = [templatefile("files/traefik-values.yaml", {
    cloudflared_version        = local.cloudflared_version
    cloudflared_configmap_name = kubernetes_config_map.cloudflared.metadata.0.name
  })]
}
