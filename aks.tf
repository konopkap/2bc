locals {
  aks_name     = join("-", ["aks", local.project_suffix_dashed])
  dns_prefix   = replace(local.aks_name, "-", "")
  pip_aks_name = join("-", ["pip", azurerm_kubernetes_cluster.k8s.name, "ingress"])
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                = local.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kubernetes_version  = var.aks_version

  dns_prefix                = local.dns_prefix
  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name           = "default"
    vm_size        = var.aks_node_size
    node_count     = var.aks_node_count
    vnet_subnet_id = azurerm_subnet.aks_subnet.id

    upgrade_settings {
      drain_timeout_in_minutes      = 0
      max_surge                     = "10%"
      node_soak_duration_in_minutes = 0
    }
  }

  linux_profile {
    admin_username = var.aks_adminusername

    ssh_key {
      key_data = tls_private_key.ssh.public_key_openssh
    }
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  tags = var.tags
}

# Below resource it's workaround as I do not have access to MC_* resource group.
resource "azurerm_public_ip" "pip_ingress" {
  name                = local.pip_aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}