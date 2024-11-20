resource "helm_release" "sample_app" {
  name       = "sample-app"
  repository = "https://konopkap.github.io/2bc"
  chart      = "sample-app"

  create_namespace = true
  namespace        = "sample-app"
  version          = var.sample_app_version

  values = [
    "${file("${path.module}/values/sample_app.yaml")}"
  ]

  depends_on = [helm_release.ingress_nginx]
}