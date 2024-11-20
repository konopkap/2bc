module "helm" {
  source = "./modules/helm"

  # ingress_nginx.tf
  ingress_nginx_pip_name = azurerm_public_ip.pip_ingress.name
  resource_group_name    = var.resource_group_name

  # sample_app.tf
  sample_app_version = var.helm_sample_app_version

  depends_on = [ azurerm_role_assignment.aks_acr ]
}