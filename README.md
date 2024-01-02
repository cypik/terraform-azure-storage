# terraform-azure-storage
# Terraform Azure Infrastructure

This Terraform configuration defines an Azure infrastructure using the Azure provider.

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [Examples](#examples)
- [License](#license)

## Introduction
This module provides a Terraform configuration for deploying various Azure resources as part of your infrastructure. The configuration includes the deployment of resource groups, virtual networks, subnets, storage.

## Usage
To use this module, you should have Terraform installed and configured for AZURE. This module provides the necessary Terraform configuration
for creating AZURE resources, and you can customize the inputs as needed. Below is an example of how to use this module:

# Examples

# Example: default

```hcl
module "storage" {
  source                        = "git::https://github.com/cypik/terraform-azure-storage.git?ref=v1.0.0"
  name                          = "app"
  environment                   = "test"
  default_enabled               = true
  resource_group_name           = module.resource_group.resource_group_name
  location                      = "North Europe"
  storage_account_name          = "tes3dfjg"
  public_network_access_enabled = true
  ##   Storage Container
  containers_list = [
    { name = "app-test", access_type = "private" },
    { name = "app2", access_type = "private" },
  ]
  ##   Storage File Share
  file_shares = [
    { name = "fileshare1", quota = 5 },
  ]
  ##   Storage Tables
  tables = ["table1"]
  ## Storage Queues
  queues                  = ["queue1"]
  enable_private_endpoint = false
}
```

# Example: storage_with_cmk

```hcl
module "storage_with_cmk" {
  source                   = "git::https://github.com/cypik/terraform-azure-storage.git?ref=v1.0.0"
  name                     = "app1"
  environment              = "test"
  label_order              = ["name", "environment", ]
  resource_group_name      = module.resource_group.resource_group_name
  location                 = module.resource_group.resource_group_location
  storage_account_name     = "stogkqp0896"
  account_kind             = "BlockBlobStorage"
  account_tier             = "Premium"
  identity_type            = "UserAssigned"
  object_id                = ["77xxxxxxxxxxxxxxxxxxxxxxxxxxx93"]
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
```

This example demonstrates how to create various AZURE resources using the provided modules. Adjust the input values to suit your specific requirements.

## Module Inputs
- 'name':  Specifies the name of the storage account.
- 'resource_group_name': The name of the resource group in which to create the storage account.
- 'location': Specifies the supported Azure location where the resource exists.

## Module Outputs
- 'id': The ID of the Storage Account.

## Examples
For detailed examples on how to use this module, please refer to the '[examples](https://github.com/cypik/terraform-azure-storage/blob/master/_example)' directory within this repository.

## License
This Terraform module is provided under the '[License Name]' License. Please see the [LICENSE](https://github.com/cypik/terraform-azure-storage/blob/master/LICENSE) file for more details.

## Author
Your Name
Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.
