resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  create_namespace = true
  namespace        = "ingress-nginx"
  version          = "4.11.3"

  values = [
    templatefile("${path.module}/values/ingress_nginx.yaml", {
      pip_name            = var.ingress_nginx_pip_name
      resource_group_name = var.resource_group_name
    })
  ]
}