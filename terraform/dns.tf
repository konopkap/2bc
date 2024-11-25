resource "azurerm_dns_zone" "dns" {
  name                = "patryk2bc.example.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_dns_a_record" "ingres_nginx" {
  zone_name           = azurerm_dns_zone.dns.name
  name                = "ingress-nginx"
  resource_group_name = var.resource_group_name

  ttl     = 300
  records = [azurerm_public_ip.pip_ingress.ip_address]

  tags = var.tags
}

resource "azurerm_dns_cname_record" "sample_app" {
  zone_name           = azurerm_dns_zone.dns.name
  name                = "sample-app"
  resource_group_name = var.resource_group_name

  ttl    = 300
  record = "ingress-nginx"

  tags = var.tags
}