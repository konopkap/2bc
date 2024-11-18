locals {
  acr_name = join("", ["acr", local.project_suffix])
}

resource "azurerm_container_registry" "acr" {
  name                = local.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location

  sku = "Basic"

  tags = var.tags
}