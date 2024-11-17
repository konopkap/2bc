module "helm" {
  source = "./modules/helm"

  ingress_nginx_pip_name = azurerm_public_ip.pip_ingress.name
  resource_group_name    = var.resource_group_name
}