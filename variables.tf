#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "repository" {
  type        = string
  default     = "https://github.com/cypik/terraform-azure-storage"
  description = "Terraform current module repo"
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment", ]
  description = "Label order, e.g. sequence of application name and environment `name`,`environment`,'attribute' [`webserver`,`qa`,`devops`,`public`,] ."
}

variable "managedby" {
  type        = string
  default     = "info@cypik.com"
  description = "ManagedBy, eg 'info@cypik.com'"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Set to false to prevent the module from creating any resources."
}

variable "resource_group_name" {
  type        = string
  default     = ""
  description = "A container that holds related resources for an Azure solution"
}

variable "location" {
  type        = string
  default     = "North Europe"
  description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
}

variable "storage_account_name" {
  type        = string
  default     = ""
  description = "The name of the azure storage account"
}

variable "account_tier" {
  type        = string
  default     = "Standard"
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
}

variable "access_tier" {
  type        = any
  default     = "Hot"
  description = "Defines the access tier for BlobStorage and StorageV2 accounts. Valid options are Hot and Cool."
}

variable "account_replication_type" {
  type        = string
  default     = "GRS"
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS. Changing this forces a new resource to be created when types LRS, GRS and RAGRS are changed to ZRS, GZRS or RAGZRS and vice versa."
}

variable "https_traffic_only_enabled" {
  type        = bool
  default     = true
  description = " Boolean flag which forces HTTPS if enabled, see here for more information."
}

variable "account_kind" {
  type        = string
  default     = "StorageV2"
  description = "The type of storage account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
}

variable "min_tls_version" {
  type        = string
  default     = "TLS1_2"
  description = "The minimum supported TLS version for the storage account"
}


variable "containers_list" {
  type        = list(object({ name = string, access_type = string }))
  default     = []
  description = "List of containers to create and their access levels."
}

variable "network_rules" {
  type = list(object({ default_action = string, ip_rules = list(string), bypass = list(string) }))
  default = [{
    default_action = "Deny"
    ip_rules       = ["0.0.0.0/0"]
    bypass         = ["AzureServices"]
  }]
  description = "List of objects that represent the configuration of each network rules."
}

#network_rules = [
#  {
#    default_action = "Deny"
#    ip_rules       = ["0.0.0.0/0"]
#    bypass         = ["AzureServices"]
#  }
#]

variable "is_hns_enabled" {
  type        = bool
  default     = false
  description = "Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2. Changing this forces a new resource to be created."
}

variable "sftp_enabled" {
  type        = bool
  default     = false
  description = "Boolean, enable SFTP for the storage account"
}

variable "enable_advanced_threat_protection" {
  default     = true
  type        = bool
  description = "Boolean flag which controls if advanced threat protection is enabled."
}

variable "file_shares" {
  type        = list(object({ name = string, quota = number }))
  default     = []
  description = "List of containers to create and their access levels."
}

variable "tables" {
  type        = list(string)
  default     = []
  description = "List of storage tables."
}

variable "queues" {
  type        = list(string)
  default     = []
  description = "List of storages queues"
}

variable "management_policy" {
  type = list(object({
    prefix_match               = set(string),
    tier_to_cool_after_days    = number,
    tier_to_archive_after_days = number,
    delete_after_days          = number,
    snapshot_delete_after_days = number
  }))
  default = [{
    prefix_match               = null
    tier_to_cool_after_days    = 0,
    tier_to_archive_after_days = 50,
    delete_after_days          = 100,
    snapshot_delete_after_days = 30
  }]
  description = "Configure Azure Storage firewalls and virtual networks"
}

# Identity
variable "identity_type" {
  type        = string
  default     = "SystemAssigned"
  description = "Specifies the type of Managed Service Identity that should be configured on this Storage Account. Possible values are `SystemAssigned`, `UserAssigned`, `SystemAssigned, UserAssigned` (to enable both)."
}

variable "key_vault_id" {
  type    = string
  default = null
}

variable "shared_access_key_enabled" {
  type        = bool
  default     = true
  description = " Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is true."
}

variable "infrastructure_encryption_enabled" {
  type        = bool
  default     = true
  description = " Is infrastructure encryption enabled? Changing this forces a new resource to be created. Defaults to false."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = true
  description = "Whether the public network access is enabled? Defaults to true."
}

variable "default_to_oauth_authentication" {
  type        = bool
  default     = false
  description = "Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account. The default value is false"
}

variable "cross_tenant_replication_enabled" {
  type        = bool
  default     = true
  description = "Should cross Tenant replication be enabled? Defaults to true."
}

variable "allow_nested_items_to_be_public" {
  type        = bool
  default     = true
  description = "Allow or disallow nested items within this Account to opt into being public. Defaults to true."
}

variable "object_id" {
  type    = list(string)
  default = []
}

## Private endpoint

variable "virtual_network_id" {
  type        = string
  default     = ""
  description = "The name of the virtual network"
}

variable "subnet_id" {
  type        = string
  default     = ""
  description = "The resource ID of the subnet"
}

variable "enable_private_endpoint" {
  type        = bool
  default     = true
  description = "enable or disable private endpoint to storage account"
}

variable "existing_private_dns_zone" {
  type        = string
  default     = null
  description = "Name of the existing private DNS zone"
}

variable "existing_private_dns_zone_resource_group_name" {
  type        = string
  default     = ""
  description = "The name of the existing resource group"
}

## Addon vritual link
variable "addon_vent_link" {
  type        = bool
  default     = false
  description = "The name of the addon vnet "
}

variable "addon_resource_group_name" {
  type        = string
  default     = ""
  description = "The name of the addon vnet resource group"
}

variable "addon_virtual_network_id" {
  type        = string
  default     = ""
  description = "The name of the addon vnet link vnet id"
}


# Diagnosis Settings Enable

variable "diff_sub" {
  type        = bool
  default     = false
  description = "The name of the addon vnet "
}

variable "management_policy_enable" {
  type    = bool
  default = false
}

variable "default_enabled" {
  type    = bool
  default = false
}

variable "multi_sub_vnet_link" {
  type        = bool
  default     = false
  description = "Flag to control creation of vnet link for dns zone in different subscription"
}

variable "alias_sub" {
  type    = string
  default = null
}

variable "nfsv3_enabled" {
  type        = bool
  default     = false
  description = "Is NFSv3 protocol enabled? Changing this forces a new resource to be created."
}

variable "custom_domain_name" {
  type        = string
  default     = null
  description = "The Custom Domain Name to use for the Storage Account, which will be validated by Azure."
}

variable "use_subdomain" {
  type        = bool
  default     = false
  description = "Should the Custom Domain Name be validated by using indirect CNAME validation?"
}

# Data protection
variable "storage_blob_data_protection" {
  description = "Storage account blob Data protection parameters."
  type = object({
    change_feed_enabled                       = optional(bool, false)
    versioning_enabled                        = optional(bool, false)
    last_access_time_enabled                  = optional(bool, false)
    delete_retention_policy_in_days           = optional(number, 0)
    container_delete_retention_policy_in_days = optional(number, 0)
    container_point_in_time_restore           = optional(bool, false)
  })
  default = {
    change_feed_enabled                       = false
    last_access_time_enabled                  = false
    versioning_enabled                        = false
    delete_retention_policy_in_days           = 7
    container_delete_retention_policy_in_days = 7
  }
}

variable "storage_blob_cors_rule" {
  description = "Storage Account blob CORS rule. Please refer to the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#cors_rule) for more information."
  type = object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  })
  default = null
}

variable "restore_policy" {
  type        = bool
  default     = false
  description = "Wheteher or not create restore policy"
}

# SAS Policy
variable "enable_sas_policy" {
  type        = bool
  default     = false
  description = "Enable or disable the creation of the sas_policy block."
}

variable "sas_policy_settings" {
  type = list(object({
    expiration_period = string
    expiration_action = string
  }))
  default = [
    {
      expiration_period = "7.00:00:00"
      expiration_action = "Log"
    }
  ]
}

variable "static_website_config" {
  type = object({
    index_document     = optional(string)
    error_404_document = optional(string)
  })
  default     = null
  description = "Static website configuration. Can only be set when the `account_kind` is set to `StorageV2` or `BlockBlobStorage`."
}

# File Share Authentication
variable "file_share_authentication" {
  description = "Storage Account file shares authentication configuration."
  type = object({
    directory_type = string
    active_directory = optional(object({
      storage_sid         = string
      domain_name         = string
      domain_sid          = string
      domain_guid         = string
      forest_name         = string
      netbios_domain_name = string
    }))
  })
  default = null

  validation {
    condition = var.file_share_authentication == null || (
      contains(["AADDS", "AD", ""], try(var.file_share_authentication.directory_type, ""))
    )
    error_message = "`file_share_authentication.directory_type` can only be `AADDS` or `AD`."
  }
  validation {
    condition = var.file_share_authentication == null || (
      try(var.file_share_authentication.directory_type, null) == "AADDS" || (
        try(var.file_share_authentication.directory_type, null) == "AD" &&
        try(var.file_share_authentication.active_directory, null) != null
      )
    )
    error_message = "`file_share_authentication.active_directory` block is required when `file_share_authentication.directory_type` is set to `AD`."
  }
}

# Routing
variable "enable_routing" {
  type        = bool
  default     = false
  description = "Enable or disable the creation of the routing block."
}

variable "routing" {
  type = list(object({
    publish_internet_endpoints  = bool
    publish_microsoft_endpoints = bool
    choice                      = string
  }))
  default = [
    {
      publish_internet_endpoints  = false
      publish_microsoft_endpoints = false
      choice                      = "MicrosoftRouting"
    }
  ]
}