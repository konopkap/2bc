terraform {
  backend "azurerm" {
    resource_group_name  = "Patryk-Candidate"
    storage_account_name = "saweterraformpatryk2bc"
    container_name       = "tfstate"
    key                  = "patryk.tfstate"
  }
}