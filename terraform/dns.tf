resource "azurerm_dns_zone" "dns" {
  name                = "patryk2bc.example.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_dns_a_record" "ingres_nginx" {
  zone_name           = azurerm_dns_zone.dns.name
  name                = "ingress-nginx"
  #some comment
  resource_group_name = var.resource_group_name

  ttl     = 300
  records = [azurerm_public_ip.pip_ingress.ip_address]

  tags = var.tags
}