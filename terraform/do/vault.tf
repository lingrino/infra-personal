resource "kubernetes_namespace" "vault" {
  metadata {
    generate_name = "vault-"
  }
}
