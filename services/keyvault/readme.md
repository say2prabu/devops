#Example .tfvars

azure_region      = "westeurope"
organization_code = "dan"
environment_code  = "d"
subscription_code = "lnd1"

backend_suffix = [
  "dev"
]

rsg_tags = {
  "AtosManaged" = "true"
}

disk_encryption_enabled = "false"
sku                     = "standard"
soft_delete_in_days     = "7"
network_acls = [{
  bypass                     = "AzureServices"
  default_action             = "Allow"
  ip_rules                   = ["172.0.0.10"]
  virtual_network_subnet_ids = []
}]
tags = {
  "AtosManaged" = "true"
  "Owner"       = "user1"
}
access_policies = {
  policy1 = {
    object_id               = "68e0060b-6a4d-45d6-82e8-a683220b979b"
    key_permissions         = ["Get", "List"]
    secret_permissions      = ["Get"]
    certificate_permissions = ["Get", "Create"]
    storage_permissions     = ["Get"]
  }
  policy2 = {
    object_id               = "ca552af0-cb0b-4ea7-ba67-3175eead935c"
    key_permissions         = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"]
    secret_permissions      = ["Get", "Delete", "List", "Set", "Purge"]
    certificate_permissions = ["Create", "Backup", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]
    storage_permissions     = []
  }
}

secrets = {
  secret1 = {
    secret_value = "value1"
  }
  secret2 = {
    secret_value = "value2"
  }
}

keys = {
  key1 = {
    key_type = "RSA"
    key_size = "2048"
    key_opts = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
  }
  key2 = {
    key_type = "RSA"
    key_size = "2048"
    key_opts = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
  }
}


certificates = {
  certimp1 = {
    cert_import_filepath = "C:\\Azure\\cert\\P2SClient.pfx"
    cert_password        = "1a2b3c4d"
    is_imported          = "true"
  },
  certgen1 = {
    is_imported        = "false"
    issuer_name        = "Self"
    exportable         = "true"
    key_size           = "2048"
    key_type           = "RSA"
    reuse_key          = "true"
    action_type        = "AutoRenew"
    days_before_expiry = "30"
    content_type       = "application/x-pkcs12"
    extended_key_usage = ["1.3.6.1.5.5.7.3.1"]
    key_usage          = ["cRLSign", "dataEncipherment", "digitalSignature", "keyAgreement", "keyCertSign", "keyEncipherment"]
    dns_names          = ["internal.contoso.com", "domain.hello.world"]
    subject_name       = "CN=hello-world"
    validity_in_months = "12"
  }
}
