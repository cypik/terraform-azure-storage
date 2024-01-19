provider "azurerm" {
  features {}
}

##-----------------------------------------------------------------------------
## Resource Group module call
##-----------------------------------------------------------------------------
module "resource_group" {
  source      = "cypik/resource-group/azure"
  version     = "1.0.1"
  name        = "app2"
  environment = "tested"
  location    = "North Europe"
}


##-----------------------------------------------------------------------------
## Virtual Network module call.
##-----------------------------------------------------------------------------
module "vnet" {
  source              = "cypik/vnet/azure"
  version             = "1.0.1"
  name                = "app"
  environment         = "test"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_space       = "10.0.0.0/16"
}

##-----------------------------------------------------------------------------
## Subnet module call.
##-----------------------------------------------------------------------------
module "subnet" {
  source               = "cypik/subnet/azure"
  version              = "1.0.1"
  name                 = "app"
  environment          = "test"
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = module.vnet.name

  #subnet
  subnet_names    = ["subnet1"]
  subnet_prefixes = ["10.0.1.0/24"]

  # route_table
  enable_route_table = true
  route_table_name   = "default_subnet"
  routes = [
    {
      name           = "rt-test"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "Internet"
    }
  ]
}

##-----------------------------------------------------------------------------
## Key Vault module call.
##-----------------------------------------------------------------------------
module "vault" {
  depends_on                  = [module.vnet]
  source                      = "cypik/key-vault/azure"
  version                     = "1.0.1"
  name                        = "ytjd457fdk"
  environment                 = "test"
  sku_name                    = "standard"
  resource_group_name         = module.resource_group.resource_group_name
  subnet_id                   = module.subnet.default_subnet_id
  virtual_network_id          = module.vnet.id
  enable_private_endpoint     = true
  enable_rbac_authorization   = true
  purge_protection_enabled    = true
  enabled_for_disk_encryption = true
  principal_id                = ["xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"]
  role_definition_name        = ["Key Vault Administrator"]

}

##    Storage Account
module "storage-with-cmk" {
  source                   = "../.."
  name                     = "app"
  environment              = "test"
  label_order              = ["name", "environment", ]
  resource_group_name      = module.resource_group.resource_group_name
  location                 = module.resource_group.resource_group_location
  storage_account_name     = "sg64refgs6"
  account_kind             = "BlockBlobStorage"
  account_tier             = "Premium"
  identity_type            = "UserAssigned"
  object_id                = ["xxxxxxxxxxxxxxxxxxxxxxxxxxxx"]
  account_replication_type = "ZRS"

  ###customer_managed_key can only be set when the account_kind is set to StorageV2 or account_tier set to Premium, and the identity type is UserAssigned.
  key_vault_id = module.vault.id

  ##   Storage Container
  containers_list = [
    { name = "app-test", access_type = "private" },
  ]

  virtual_network_id = module.vnet.id
  subnet_id          = module.subnet.default_subnet_id

}
