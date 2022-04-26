# terraform-azurerm-keyvault
Terraform module to create an Azure Keyvault, and dinamically create Keyvault Access Policies, Secrets, Keys, Certificates (Import/Generate) and Network ACL's.

## Description
Azure Key Vault is used for storing and management of below items:

Secrets Management - Azure Key Vault can be used to Securely store and tightly control access to tokens, passwords, certificates, API keys, and other secrets
Key Management - Azure Key Vault can be used as a Key Management solution. Azure Key Vault makes it easy to create and control the encryption keys used to encrypt your data.
Certificate Management - Azure Key Vault lets you easily provision, manage, and deploy public and private Transport Layer Security/Secure Sockets Layer (TLS/SSL) certificates for use with Azure and your internal connected resources.
Azure Key Vault has two service tiers: Standard, which encrypts with a software key, and a Premium tier, which includes hardware security module(HSM)-protected keys.

## Azure Keyvault module usage

As this module can dinamically deploy Keyvault properties (Keys, Secrets, Certificates, etc), in order to properly deploy the Azure Keyvault module, the following things needs to be taken into consideration:

- The following variables were created as a map structure to declare the configuration for each property:
   - access_policies         
   - secrets                 
   - keys                    
   - certificates
   - network_acls

- The variables above are used in a for_each loop inside the keyvault module so you can declare as many elements as it is required by the use case (see usage example in the .tfvars example below)

- "access_policies" variable:
```hcl
  access_policies = {
  policy1 = {
    object_id               = "string"
    key_permissions         = [list of strings]
    secret_permissions      = [list of strings]
    certificate_permissions = [list of strings]
    storage_permissions     = [list of strings]
  }
}

NOTE: In order to properly deploy Keys, Secrets, Certificates, etc, the object ID of the user/service princial who runs the Terraform deployment, needs to be added with correct permissions.
```
- "secrets" variable:
```hcl
  secrets = {
    secret1 = {
      secret_value = "string"
    }
  }
```
- "keys" variable:
```hcl
  keys = {
    key1 = {
      key_type = "string"
      key_size = "number"
      key_opts = [list of strings]
    }
  }
```
- "certificates" variable:

  This variable is a bit different than the other ones as this variables accomodates both Creation of new Certificate but also Import of an existing Certificate.
  The logic behid is driven by the key "is_imported" inside the variable.

  - By setting the value of the key "is_imported" to "true" a resource for Importing the certificate will be deployed and the following variable structure needs to be used:

```hcl
  certificates = {
  certimp1 = {
    cert_import_filepath = "string"
    cert_password        = "string"
    is_imported          = "bool"
  }
}
```

  - By setting the value of the key "is_imported" to "false" a resource for Creating the certificate will be deployed and the following variable structure needs to be used:

```hcl
  certificates = {
  certgen1 = {
    is_imported        = "string"
    issuer_name        = "string"
    exportable         = "bool"
    key_size           = "number"
    key_type           = "string"
    reuse_key          = "bool"
    action_type        = "string"
    days_before_expiry = "number"
    content_type       = "string"
    extended_key_usage = [list of strings]
    key_usage          = [list of strings]
    dns_names          = [list of strings]
    subject_name       = "string"
    validity_in_months = "number"
  }
}
```
  - Of course in the same "certificates" variable you can create multiple certificates (Generated and Imported).

  - "network_acls" variable:

  ```hcl
    network_acls = [{
    bypass                     = "string"
    default_action             = "string"
    ip_rules                   = [list of strings]
    virtual_network_subnet_ids = [list of strings]
    }]
 
```


## Module Example Use
```hcl
module "keyvault" {
  source = "../../modules/terraform-azurerm-keyvault"

  name                    = module.keyvault_naming.keyvault.name
  location                = module.keyvault_resourcegroup.resource_group_location
  resource_group_name     = module.keyvault_resourcegroup.resource_group_name
  disk_encryption_enabled = var.disk_encryption_enabled
  sku                     = var.sku
  soft_delete_in_days     = var.soft_delete_in_days
  network_acls            = var.network_acls
  tags                    = var.tags
  access_policies         = var.access_policies
  secrets                 = var.secrets
  keys                    = var.keys
  certificates            = var.certificates
}


```

## Module Arguments

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | `string` | true | Name of the Azure KeyVault to be deployed. |
| `resource_group_name` | `string` | true | The name of the resource group in which to create the Keyvault. |
| `location` | `string` | true | Resource location. |
| `disk_encryption_enabled` | `bool` | true | Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets |
| `sku` | `string` | true | KeyVault SKU. Possible values are standard and premium. |
| `soft_delete_in_days` | `number` | true | The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90 |
| `network_acls` | `map` | true | One ore more Network ACL configuration blocks. See above detailed description |
| `access_policies` | `any` | true | One or more access KeyVault Access policy confgiuration blocks. See above detailed description |
| `secrets` | `any` | true | One or more KeyVault Secret confgiuration blocks. See above detailed description |
| `keys` | `any` | true | One or more KeyVault Key confgiuration blocks. See above detailed description |
| `certificates` | `any` | true | One or more KeyVault Certificate confgiuration blocks. See above detailed description |
| `tags` | `map` | false | A mapping of tags to assign to the resource. |

For a complete list of all the possible arguments (terraform variables), see the variables.tf file in this modules folder.
## Module outputs

| Name | Description | Value
| --- | --- | --- |
| `id` | The resource ID of the created KeyVaut. | `azurerm_key_vault.keyvault.id` |

## Root Module usage

If needed, the Azure Analysis Services child module can be called from a root module. Root module example usage:

```hcl
module "keyvault_naming" {
  source = "../../modules/terraform-naming"

  azure_region      = var.azure_region
  organization-code = var.organization_code
  environment-code  = var.environment_code
  subscription-code = var.subscription_code
  suffix            = var.backend_suffix
}
module "keyvault_resourcegroup" {
  source = "../../modules/terraform-azurerm-resourcegroup"

  name     = module.keyvault_naming.resource_group.name
  location = module.keyvault_naming.azure_region
  tags     = var.rsg_tags
}
module "keyvault" {
  source = "../../modules/terraform-azurerm-keyvault"

  name                    = module.keyvault_naming.keyvault.name
  location                = module.keyvault_resourcegroup.resource_group_location
  resource_group_name     = module.keyvault_resourcegroup.resource_group_name
  disk_encryption_enabled = var.disk_encryption_enabled
  sku                     = var.sku
  soft_delete_in_days     = var.soft_delete_in_days
  network_acls            = var.network_acls
  tags                    = var.tags
  access_policies         = var.access_policies
  secrets                 = var.secrets
  keys                    = var.keys
  certificates            = var.certificates
}

```

Example .tfvars usage for root module:

```hcl
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

```

## License
Atos, all rights protected - 2021.