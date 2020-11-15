resource "kubernetes_namespace" "hello" {
  metadata {
    generate_name = "hello-"
  }
}
