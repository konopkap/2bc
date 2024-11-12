locals {
  pip_vm_name = join("-", ["pip", local.vm_name])
  nic_name    = join("-", ["nic", local.vm_name])
  vm_name     = join("-", ["vm", local.project_suffix_dashed])
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
}

resource "azurerm_public_ip" "pip_vm" {
  name                = local.pip_vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"

  tags = var.tags
}

resource "azurerm_network_interface" "nic" {
  name                = local.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "config"
    subnet_id                     = azurerm_subnet.general_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip_vm.id
  }

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = local.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name

  admin_username        = var.vm_adminusername
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = var.vm_size

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  admin_ssh_key {
    username   = var.vm_adminusername
    public_key = tls_private_key.ssh.public_key_openssh
  }

  custom_data = filebase64("${path.module}/scripts/bootstrap.sh")

  tags = var.tags
}
