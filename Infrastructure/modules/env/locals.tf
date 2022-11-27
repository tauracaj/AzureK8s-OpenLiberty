locals {
  name_prefix  = var.name_prefix != "" ? replace(var.name_prefix, "/[a-z0-9]/", "$0-") : ""
  appgw_default_name = "${var.appgw_name}-appgw-${var.environment}"
  appgwname          = coalesce(local.appgw_default_name, var.appgw_name)

  #appgw_frontend_ip_configuration_name      = coalesce(var.appgw_frontend_ip_configuration_name, "${local.appgwname}-frontipconfig")
  appgw_ip_configuration_name       = coalesce(var.appgw_ip_configuration_name, "${local.appgwname}-ipconfig")
  backend_address_pool_name      = "${azurerm_virtual_network.aksvnet.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.aksvnet.name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.aksvnet.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.aksvnet.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.aksvnet.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.aksvnet.name}-rqrt"
  
}