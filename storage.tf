locals {
  sa_name = replace(join("", ["sa", "diag", local.vm_name]), "-", "")
}

resource "azurerm_storage_account" "diag" {
  name                = local.sa_name
  location            = var.location
  resource_group_name = var.resource_group_name

  account_tier             = "Standard"
  account_replication_type = "LRS"
}