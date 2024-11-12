resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  create_namespace = true
  namespace        = "cert-manager"
  version          = "v1.16.1"

  values = [
    "${file("${path.module}/values/cert_manager.yaml")}"
  ]
}