# Create Public IP
resource "azurerm_public_ip" "appgw-pubip" {
  name                = "${var.appgw_name}-ip-${var.environment}"
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = azurerm_resource_group.aks_rg.location
  allocation_method   = var.appgw_public_ip_allocation_method
  sku                 = var.appgw_public_ip_sku
  zones = var.appgw_zones

  # Add Tags
  tags = {
    "environment" = "${var.environment}"
    "owner"       = "${var.owner}"
    "department"  = "${var.department}"
  }
}

#WAF Policy
resource "azurerm_web_application_firewall_policy" "appgw-wafpolicy" {
  name                = "${var.appgw_name}-wafpolicy-${var.environment}"
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = azurerm_resource_group.aks_rg.location
  # Add Tags
  tags = {
    "environment" = "${var.environment}"
    "owner"       = "${var.owner}"
    "department"  = "${var.department}"
  }

  custom_rules {
    name      = "Rule1"
    priority  = 1
    rule_type = "MatchRule"

    match_conditions {
      match_variables {
        variable_name = "RemoteAddr"
      }

      operator           = "IPMatch"
      negation_condition = false
      match_values       = ["192.168.1.0/24", "10.0.0.0/24"]
    }

    action = "Block"
  }

  custom_rules {
    name      = "Rule2"
    priority  = 2
    rule_type = "MatchRule"

    match_conditions {
      match_variables {
        variable_name = "RemoteAddr"
      }

      operator           = "IPMatch"
      negation_condition = false
      match_values       = ["192.168.1.0/24"]
    }

    match_conditions {
      match_variables {
        variable_name = "RequestHeaders"
        selector      = "UserAgent"
      }

      operator           = "Contains"
      negation_condition = false
      match_values       = ["Windows"]
    }

    action = "Block"
  }

  policy_settings {
    enabled                     = true
    mode                        = "Prevention"
    request_body_check          = true
    file_upload_limit_in_mb     = 100
    max_request_body_size_in_kb = 128
  }

  managed_rules {
    exclusion {
      match_variable          = "RequestHeaderNames"
      selector                = "x-company-secret-header"
      selector_match_operator = "Equals"
    }
    exclusion {
      match_variable          = "RequestCookieNames"
      selector                = "too-tasty"
      selector_match_operator = "EndsWith"
    }

    managed_rule_set {
      type    = "OWASP"
      version = "3.1"
      rule_group_override {
        rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
        disabled_rules = [
          "920300",
          "920440"
        ]
      }
    }
  }

}

#Create App Gw
resource "azurerm_application_gateway" "app_gw" {
  name                = local.appgwname #"${var.appgw_name}-appgw-${var.environment}"
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = azurerm_resource_group.aks_rg.location
  firewall_policy_id  = azurerm_web_application_firewall_policy.appgw-wafpolicy.id
  zones = var.appgw_zones

  sku {
    name     = var.appgw_sku_name
    tier     = var.appgw_sku_tier
    capacity = var.appgw_sku_capacity
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name #"${var.appgw_name}-frontend-ip-configuration"
    public_ip_address_id = azurerm_public_ip.appgw-pubip.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_port {
    name = "httpsPort"
    port = 443
  }

  gateway_ip_configuration {
    name      = local.appgw_ip_configuration_name #"${var.appgw_name}-ip-configuration"
    subnet_id = azurerm_subnet.aks-puba.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 1
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Http"
  }

  # Request routing rule

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    priority = 100
  }

  # Add Tags
  tags = {
    "environment" = "${var.environment}"
    "owner"       = "${var.owner}"
    "department"  = "${var.department}"
  }

  depends_on = [azurerm_virtual_network.aksvnet, azurerm_public_ip.appgw-pubip, azurerm_web_application_firewall_policy.appgw-wafpolicy]  
}

