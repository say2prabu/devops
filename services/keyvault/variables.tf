variable "azure_region" {
  type = string
}

variable "organization_code" {
  type = string
}

variable "environment_code" {
  type = string
}

variable "subscription_code" {
  type = string
}

variable "backend_suffix" {
  type = list(string)
}
variable "disk_encryption_enabled" {
  type        = bool
  description = "Keyvault enabled for Disk Encryption. True/False"
}
variable "sku" {
  type        = string
  description = "SKU for keyvault. Accepted values: standard or premium"
}
variable "soft_delete_in_days" {
  type = number
  description = "The number of days that items should be retained for once soft-deleted. This value can be between 7 and 90"
}
variable "network_acls" {
  description = "nested acls"
  type = set(object(
    {
      bypass                     = string
      default_action             = string
      ip_rules                   = list(string)
      virtual_network_subnet_ids = list(string)
    }
  ))
  default = []
}
variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}
variable "rsg_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}
variable "access_policies" {
  type        = any
  description = "Map of access policy configurations for keyvault. If no access policy is needed, leave empty variable, otherwise: (i.e. policy1 = {object_id = '68e0060b-6a4d-45d6-82e8-a683220b979b' key_permissions = ['Get', 'List'] secret_permissions = ['Get'] certificate_permissions = ['Get', 'Create'] storage_permissions = ['Get']})"
}
variable "secrets" {
  type        = any
  description = "Map of secrets for keyvault. If no secret is needed, leave empty variable, otherwise: (i.e. secrets = {secret1 = {secret_value = 'value1'})"
}
variable "keys" {
  type        = any
  description = "Map of keys for keyvault. If no key is needed, leave empty variable, otherwise: (i.e.keys = {key1 = {key_type = 'RSA' key_size = '2048' key_opts = ['decrypt', 'encrypt', 'sign', 'unwrapKey', 'verify', 'wrapKey']})}"
}
variable "certificates" {
  type        = any
  description = "Map of certificates for keyvault. If no certificate is needed, leave empty variable, otherwise: (i.e.keys = {key1 = {key_type = 'RSA' key_size = '2048' key_opts = ['decrypt', 'encrypt', 'sign', 'unwrapKey', 'verify', 'wrapKey']})}"
}