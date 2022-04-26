variable "name" {
  type        = string
  description = "Specifies the name of the storage account"
}
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account."
}
variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}
variable "account_kind" {
  type        = string
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
}
variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium."
}
variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
}
variable "access_tier" {
  type        = string
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool"
  default     = "Hot"
}
variable "enable_https_traffic_only" {
  type        = bool
  description = "Boolean flag which forces HTTPS if enabled."
  default     = true
}
variable "allow_blob_public_access" {
  type        = bool
  description = "Boolean flag to allow or disallow public access to all blobs or containers in the storage account."
  default     = false
}
variable "shared_access_key_enabled" {
  description = "Boolean flag which indicates whether the storage account permits requests to be authorized with the account access key via Shared Key."
  default     = true
}
variable "min_tls_version" {
  type        = string
  description = "The minimum supported TLS version for the storage account."
  default     = "TLS1_2"
}
variable "change_feed_enabled" {
  type        = bool
  description = "Storage blob properties - change feed enable"
}
variable "is_hns_enabled" {
  type        = bool
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2. This can only be true when account_tier is Standard or when account_tier is Premium and account_kind is BlockBlobStorage."
}
variable "versioning_enabled" {
  type        = bool
  description = "Storage blob properties - versioning enable"
}

variable "blob_delete_retention_policy" {
  type        = number
  description = "Specifies the number of days that the blob should be retained in days."
}
variable "container_delete_retention_policy" {
  type        = number
  description = "Specifies the number of days that the container should be retained in days."
}
variable "container_name" {
  type        = set(string)
  description = "The name of the container(s) which should be created within the Storage Account."
  default     = []
}
variable "container_access_type" {
  type        = string
  description = "The Access Level configured for this Container. Possible values are blob, container or private. Defaults to private."
  default     = "private"
}
variable "share_name" {
  type        = set(string)
  description = "The name of the share(s). Must be unique within the storage account where the share is located."
  default     = []
}
variable "share_quota" {
  type        = number
  description = "The maximum size of the share, in gigabytes."
  default     = 100
}
variable "queue_name" {
  type        = set(string)
  description = "The name of the queue(s) which should be created within the Storage Account."
  default     = []
}
variable "table_name" {
  type        = set(string)
  description = "The name of the table(s) which should be created within the Storage Account."
  default     = []
}
variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}
variable "default_action" {
  type        = string
  description = "Specifies the default action of allow or deny when no other rules match. Valid options are Deny or Allow."
}
variable "ip_rules" {
  type        = list(any)
  description = "List of public IP or IP ranges in CIDR Format. Only IPV4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed."
}
variable "bypass" {
  type        = list(any)
  description = "Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. Valid options are any combination of Logging, Metrics, AzureServices, or None"
}
