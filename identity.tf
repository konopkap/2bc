locals {
  identity_name  = join("-", ["identity", azurerm_kubernetes_cluster.k8s.name, "cert-manager"])
  federated_name = join("-", ["fed-cred", azurerm_kubernetes_cluster.k8s.name, "cert-manager"])
}

resource "azurerm_user_assigned_identity" "cert_manager" {
  name                = local.identity_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_federated_identity_credential" "cert_manager" {
  name                = local.federated_name
  resource_group_name = var.resource_group_name

  audience  = ["api://AzureADTokenExchange"]
  issuer    = azurerm_kubernetes_cluster.k8s.oidc_issuer_url
  parent_id = azurerm_user_assigned_identity.cert_manager.id
  subject   = "system:serviceaccount:cert-manager:cert-manager"
}