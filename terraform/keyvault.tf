locals {
  kv_name = join("-", ["kv", local.project_suffix_dashed])
}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                = local.kv_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name  = "standard"
  tenant_id = data.azurerm_client_config.current.tenant_id
}