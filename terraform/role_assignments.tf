resource "azurerm_role_assignment" "aks_dns" {
  scope                = azurerm_dns_zone.dns.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.cert_manager.principal_id
}

resource "azurerm_role_assignment" "aks_acr" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.k8s.kubelet_identity[0].object_id
}

# Below assignment it's workaround as I do not have access to MC_* resource group.
resource "azurerm_role_assignment" "aks_network_contributor" {
  scope                = "/subscriptions/27c83813-916e-49fa-8d2a-d35332fc8ca4/resourceGroups/Patryk-Candidate"
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.k8s.identity[0].principal_id
}