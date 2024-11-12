# aks.tf
output "aks_ingress_domain_name" {
  value = azurerm_dns_a_record.ingres_nginx.fqdn
}

# vm.tf
output "vm_name" {
  value = azurerm_linux_virtual_machine.vm.name
}

output "vm_public_ip" {
  value = azurerm_linux_virtual_machine.vm.public_ip_address
}