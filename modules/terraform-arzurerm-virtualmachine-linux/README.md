# terraform-azurerm-storageaccount
Terraform module to create an Windows Virtual Machine

# Prerequisites
This Application assumes that you already have a virtual net provisioned inside of the landing zone, so you are going to need the name of the vnet and subnet that you will be deploying too, and the resource group and location that the v-net resides in

## Description
An Azure storage account contains all of Azure Storage data objects: blobs, file shares, queues, tables, and disks. The storage account provides a unique namespace for your Azure Storage data that's accessible from anywhere in the world over HTTP or HTTPS. 

This module will create a Storage account with blob containers & file shares only as per the requirements of the Siemens App Transformation showcase. (Queues & tables cannot be created with this module at this time)

## Module Example Use
```hcl
  module "virtual-machine" {
    source = "../../modules/terraform-arzurerm-virtualmachine-linux"

    # variables for the rsg and vnet/subnet
    rsg_loc = "germanywestcentral"
    rsg_name = "cu1-lnd1-d-rsg-vms"
    vnet_name    = "cu1-lnd1-d-gewc-vnet-spoke"
    subnet_name  = "cu1-lnd1-d-gewc-snet-spoke-back"


    # variables for the nic
    nic_name = "vmnic01"

    # variables for the vm
    vm_name = "linuxvm001"
    vm_size = "Standard_B2ms"
    admin_username = "AzureUser"
    ssh_key = "ssh_key"
    disable_password_authentication = "true"
    admin_password = "P@ssW0rd"

    # variables for the image used by the vm
    publisher = "RedHat"
    offer = "RHEL"
    sku = "7_9"
    image_version = "latest"

    # variables for the os disk used by the vm
    caching  = "ReadWrite"
    storage_account_type = "Standard_LRS"

    # set the tags
       tags = {
    "AtosManaged" = "true"
    "AtosBackup" = "Bronze"
  }

```

## Module Arguments

| Name | Type | Required | Description | Example | Default Value 
| --- | --- | --- | --- | --- | --- 
| `azure_region` | `string` | true | The Azure location/region to which the resources are being deployed. This will be used to get the corresponding four character Atos code according to Atos DCS naming convention. | "westeurope" | NA
| `organization-code` | `string` | true | A three character Atos code according to Atos DCS naming convention indicating which organization we are deploying this automation for. When for Atos use: ats | "ats" | NA
| `environment-code` | `string` | true | A one character Atos code according to Atos DCS naming convention to indicate which environment type will be deployed to. Example 'd' for Development, 't' for Test etc. | "d" |NA
| `subscription-code` | `string` | true | A four character Atos code according to Atos DCS naming convention to indicate which subscription we are deploying the automation to. Example 'mgmt' for management, 'lnd1' for the 1st landingzone. | "ind1" | NA
| `rg_name` | `string` | true | The name of the resource group in which your virtual network resides. | "my_resource_group" | NA
| `rg_location` | `string` | true | The location in which your resource group resides| "West Europe"| NA
| `vnet_name` | `string` | true | The name of the <b>already provisioned</b> virtual net that the vm will be apart of | "cu7-lnd1-d-euwe-vnet-spoke" | NA
| `subnet_name` | `string` | true | The name of the <b>already provisioned</b> subnet that the vm will be apart of | "cu7-lnd1-d-euwe-snet-spoke-back" | NA
| `vm_size` | `string` | false | The size that you wish to provisione the vm. Sometimes you may be restricted by the choices so the only ones we were able to provision were ("Standard_B2ms","Standard_DS1_v2","Standard_F2s_v2") | "Standard_B2ms" | "Standard_DS1_v2"
| `nic_name` | `string` | false | The name of the network interface that will be attached to the vm | "my_nic_name" | "default-nic"
| `admin_username` | `string` | false | The admin username that will be used to login to the vm if needed | "admin" | "adminuser"
| `disable_password_authentication` | `string` | false | This variable will determine if you are using an ssh key to login, or a password to login to the vm. If it is set the <b>`true`</b> than you will use the `ssh_key` variable. If it is set the <b>`false`</b> than you will use the `admin_password` variable. | true | true
| `ssh_key` | `string` | false | The ssh public key that will be attached to the vm so that you can login if `disable_password_authentication` is set to `true` | "ssh_key" | "a fake ssh public key that does not work"
| `admin_password` | `string` | false | The admin password that would be used to login to the vm if `disable_password_authentication` is set to `false` | "passwordhello" | "password123!"
| `publisher` | `string` | false | The publisher of the VM image | "Canonical" | "Canonical"
| `offer` | `string` | false | The offer of the VM image | "my-offer" | "0001-com-ubuntu-server-focal"
| `sku` | `string` | false | The sku of the VM image | "my-sku" | "20_04-lts-gen2"
| `image_version` | `string` | false | The version  of the VM image | "20_04-lts-gen2" | "latest"
| `caching` | `string` | false | The different option of caching that are allowed for the os_disk. Options are ("None", "ReadOnly", "ReadWrite") | "ReadWrite" | "ReadWrite"
| `storage_account_type` | `string` | false | The storage account type of the os_disk. Options are ("Standard_LRS", "StandardSSD_LRS", "Premium_LRS") | "Standard_LRS" | "Standard_LRS"
| `tags` | `map` | false | A mapping of tags to assign to the resource. | {"key": "value"} | {"key": "value"}

## Module outputs

| Name | Description | Value
| --- | --- | --- |

# DCS Tags
| Name | Type | Description 
| --- | --- | --- 
| `AtosManaged` | `bool` | Weather or not this Virtual Machine is an Atos Managed instance (defaults to false)
| `AtosBackup` | `string` | Indicates a VM must included for backup in the Azure Recovery Services Vault that has been created in the same subscription and region as the VM. The tag value defines which backup schedule the VM must be assigned to.
| `AtosPatching` | `string` | When the AtosPatching tag is set, and the tag value is set to the name of a valid patch schedule, the VM will be added to Azure Update Management and the VM will be patched as defined in the selected update management schedule. 
| `AtosCompliance` | `bool` | A tag value of 'true' indicates that the virtual machine will be scanned for vulnerabilities using Qualys agent.
| `AtosSoftware` | `bool` | A tag value of 'true' enables rudimental (simple) pre-packaged software installations on Atos Managed Windows and Linux IaaS virtual machines through Azure-native toolsets. For VM OS Software Distribution, PowerShell Desired State Configuration (DSC) is used as the configuration management platform, enabling customer application teams 
| `AtosAntimalware` | `bool` | A tag value of 'true' indicates that the Antimalware option must be activated for the virtual machine.

## License
Atos, all rights protected - 2021.