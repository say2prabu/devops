data "azurerm_client_config" "current" {
}

resource "azurerm_key_vault" "keyvault" {
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = var.disk_encryption_enabled
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = var.sku
  soft_delete_retention_days  = var.soft_delete_in_days
  tags                        = var.tags
    dynamic "network_acls" {
    for_each = var.network_acls
    content {
      bypass                     = network_acls.value["bypass"]
      default_action             = network_acls.value["default_action"]
      ip_rules                   = network_acls.value["ip_rules"]
      virtual_network_subnet_ids = network_acls.value["virtual_network_subnet_ids"]
    }
  }
}
resource "azurerm_key_vault_access_policy" "access_policy" {
  for_each                = var.access_policies
  key_vault_id            = azurerm_key_vault.keyvault.id
  tenant_id               = data.azurerm_client_config.current.tenant_id
  object_id               = each.value.object_id
  key_permissions         = each.value.key_permissions
  secret_permissions      = each.value.secret_permissions
  certificate_permissions = each.value.certificate_permissions
  storage_permissions     = each.value.storage_permissions
}
resource "azurerm_key_vault_secret" "secret" {
  for_each     = var.secrets
  name         = each.key
  value        = each.value.secret_value
  key_vault_id = azurerm_key_vault.keyvault.id
  depends_on = [
    azurerm_key_vault_access_policy.access_policy,
  ]
}
resource "azurerm_key_vault_key" "key" {
  for_each     = var.keys
  name         = each.key
  key_vault_id = azurerm_key_vault.keyvault.id
  key_type     = each.value.key_type
  key_size     = each.value.key_size
  key_opts     = each.value.key_opts
  depends_on = [
    azurerm_key_vault_access_policy.access_policy,
  ]
}

resource "azurerm_key_vault_certificate" "kv_cert_import" {
  for_each = {
    for key, cert in var.certificates :
    key => cert if cert.is_imported == "true"
  }
  name         = each.key
  key_vault_id = azurerm_key_vault.keyvault.id
  certificate {
    contents = filebase64(each.value.cert_import_filepath)
    password = each.value.cert_password

  }
  depends_on = [
    azurerm_key_vault_access_policy.access_policy,
  ]
}

resource "azurerm_key_vault_certificate" "kv_cert_generate" {
  for_each = {
    for key, cert in var.certificates :
    key => cert if cert.is_imported == "false"
  }
  name         = each.key
  key_vault_id = azurerm_key_vault.keyvault.id

  certificate_policy {
    issuer_parameters {
      name = each.value.issuer_name
    }

    key_properties {
      exportable = each.value.exportable
      key_size   = each.value.key_size
      key_type   = each.value.key_type
      reuse_key  = each.value.reuse_key
    }

    lifetime_action {
      action {
        action_type = each.value.action_type
      }

      trigger {
        days_before_expiry = each.value.days_before_expiry
      }
    }

    secret_properties {
      content_type = each.value.content_type
    }

    x509_certificate_properties {
      # Server Authentication = 1.3.6.1.5.5.7.3.1
      # Client Authentication = 1.3.6.1.5.5.7.3.2
      extended_key_usage = each.value.extended_key_usage

      key_usage = each.value.key_usage

      subject_alternative_names {
        dns_names = each.value.dns_names
      }

      subject            = each.value.subject_name
      validity_in_months = each.value.validity_in_months
    }
  }
  depends_on = [
    azurerm_key_vault_access_policy.access_policy,
  ]
}

