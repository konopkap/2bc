resource "helm_release" "sample_app" {
  name       = "sample-app"
  repository = "https://charts.jetstack.io"
  chart      = "sample-app"

  create_namespace = true
  namespace        = "sample-app"
  version          = "0.1.0"

  values = [
    "${file("${path.module}/values/sample_app.yaml")}"
  ]
}