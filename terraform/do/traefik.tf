resource "kubernetes_namespace" "traefik" {
  metadata {
    generate_name = "traefik-"
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

  values = [file("files/traefik-values.yaml")]
}
