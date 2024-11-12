resource "helm_release" "redis" {
  name       = "redis"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"

  create_namespace = true
  namespace        = "redis"
  version          = "20.3.0"

  values = [
    "${file("${path.module}/values/redis.yaml")}"
  ]
}