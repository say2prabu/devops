variable "resource_group_name" {
  type        = string
  description = "A container that holds related resources for an Azure solution"
  default     = ""
}

variable "location" {
  type        = string
  description = "The Azure Region in which the Redis cache should be created."
}

variable "storage_account_name" {
  type        = string
  description = "The name of the hub storage account to store logs"
  default     = null
}

variable "existing_network_security_group_id" {
  type        = string
  description = "The resource id of existing network security group"
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "os_flavor" {
  type        = string
  description = "Specify the flavour of the operating system image to deploy VMSS. Valid values are `windows` and `linux`"
  default     = "windows"
}

variable "vmscaleset_name" {
  type        = string
  description = "The prefix which should be used for the name of the Virtual Machines in this Scale Set. If unspecified this defaults to the value for the name field. If the value of the name field is not a valid computer_name_prefix, then you must specify computer_name_prefix"
  default     = ""
}

variable "computer_name_prefix" {
  type        = string
  description = "Specifies the name of the virtual machine inside the VM scale set"
  default     = null
}

variable "virtual_machine_size" {
  type        = string
  description = "The Virtual Machine SKU for the Scale Set, Default is Standard_A2_V2"
  default     = "Standard_A2_v2"
}

variable "instances_count" {
  type        = number
  description = "The number of Virtual Machines in the Scale Set."
  default     = 2
}

variable "admin_username" {
  type        = string
  description = "The username of the local administrator used for the Virtual Machine."
  default     = "azureadmin"
}

variable "admin_password" {
  type        = string
  description = "The Password which should be used for the local-administrator on this Virtual Machine"
  default     = null
}

variable "custom_data" {
  type        = string
  description = "The Base64-Encoded Custom Data which should be used for this Virtual Machine Scale Set."
  default     = null
}

variable "disable_password_authentication" {
  type        = bool
  description = "Should Password Authentication be disabled on this Virtual Machine Scale Set? Defaults to true."
  #default     = true
  default = false

}

variable "overprovision" {
  type        = bool
  description = "Should Azure over-provision Virtual Machines in this Scale Set? This means that multiple Virtual Machines will be provisioned and Azure will keep the instances which become available first - which improves provisioning success rates and improves deployment time. You're not billed for these over-provisioned VM's and they don't count towards the Subscription Quota. Defaults to true."
  default     = false
}

variable "do_not_run_extensions_on_overprovisioned_machines" {
  description = "Should Virtual Machine Extensions be run on Overprovisioned Virtual Machines in the Scale Set?"
  default     = false
}

variable "enable_windows_vm_automatic_updates" {
  type        = bool
  description = "Are automatic updates enabled for Windows Virtual Machine in this scale set?"
  default     = true
}

variable "enable_encryption_at_host" {
  type        = bool
  description = " Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?"
  default     = false
}

variable "license_type" {
  description = "Specifies the type of on-premise license which should be used for this Virtual Machine. Possible values are None, Windows_Client and Windows_Server."
  default     = "None"
}

variable "platform_fault_domain_count" {
  description = "Specifies the number of fault domains that are used by this Linux Virtual Machine Scale Set."
  default     = null
}

variable "scale_in_policy" {
  description = "The scale-in policy rule that decides which virtual machines are chosen for removal when a Virtual Machine Scale Set is scaled in. Possible values for the scale-in policy rules are `Default`, `NewestVM` and `OldestVM`"
  default     = "Default"
}

variable "single_placement_group" {
  description = "Allow to have cluster of 100 VMs only"
  default     = true
}

variable "source_image_id" {
  type        = string
  description = "The ID of an Image which each Virtual Machine in this Scale Set should be based on"
  default     = null
}

variable "os_upgrade_mode" {
  type        = string
  description = "Specifies how Upgrades (e.g. changing the Image/SKU) should be performed to Virtual Machine Instances. Possible values are Automatic, Manual and Rolling. Defaults to Automatic"
  #default     = "Automatic"
  default = "Manual"
}

variable "vm_time_zone" {
  type        = string
  description = "Specifies the Time Zone which should be used by the Virtual Machine"
  default     = null
}

variable "availability_zones" {
  description = "A list of Availability Zones in which the Virtual Machines in this Scale Set should be created in"
  default     = null #[1, 2, 3]
}

variable "availability_zone_balance" {
  type        = bool
  description = "Should the Virtual Machines in this Scale Set be strictly evenly distributed across Availability Zones?"
  default     = false
}

variable "generate_admin_ssh_key" {
  type        = bool
  description = "Generates a secure private key and encodes it as PEM."
  default     = false
}

variable "admin_ssh_key_data" {
  type        = bool
  description = "specify the path to the existing ssh key to authenciate linux vm"
  default     = null
}

variable "custom_image" {
  description = "Proive the custom image to this module if the default variants are not sufficient"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = null
}

variable "linux_distribution_list" {
  type = map(object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  }))

  default = {
    ubuntu1604 = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "16.04-LTS"
      version   = "latest"
    }

    ubuntu1804 = {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }

    centos8 = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "7.5"
      version   = "latest"
    }

    coreos = {
      publisher = "CoreOS"
      offer     = "CoreOS"
      sku       = "Stable"
      version   = "latest"
    }
  }
}

variable "linux_distribution_name" {
  type        = string
  default     = "ubuntu1804"
  description = "Variable to pick an OS flavour for Linux based VMSS possible values include: centos8, ubuntu1804"
}

variable "windows_distribution_list" {
  type = map(object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  }))

  default = {
    windows2012r2dc = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2012-R2-Datacenter"
      version   = "latest"
    }

    windows2016dc = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2016-Datacenter"
      version   = "latest"
    }

    windows2019dc = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2019-Datacenter"
      version   = "latest"
    }

    mssql2017exp = {
      publisher = "MicrosoftSQLServer"
      offer     = "SQL2017-WS2016"
      sku       = "Express"
      version   = "latest"
    }
  }
}

variable "windows_distribution_name" {
  type        = string
  default     = "windows2019dc"
  description = "Variable to pick an OS flavour for Windows based VMSS possible values include: winserver, wincore, winsql"
}

variable "os_disk_storage_account_type" {
  type        = string
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values include `Standard_LRS`, `StandardSSD_LRS` and `Premium_LRS`."
  default     = "StandardSSD_LRS"
}

variable "os_disk_caching" {
  type        = string
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are `None`, `ReadOnly` and `ReadWrite`"
  default     = "ReadWrite"
}

variable "disk_encryption_set_id" {
  type        = string
  description = "The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk. The Disk Encryption Set must have the `Reader` Role Assignment scoped on the Key Vault - in addition to an Access Policy to the Key Vault"
  default     = null
}

variable "disk_size_gb" {
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Scale Set is sourced from."
  default     = null
}

variable "enable_os_disk_write_accelerator" {
  type        = bool
  description = "Should Write Accelerator be Enabled for this OS Disk? This requires that the `storage_account_type` is set to `Premium_LRS` and that `caching` is set to `None`."
  default     = false
}

variable "enable_ultra_ssd_data_disk_storage_support" {
  description = "Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine"
  default     = false
}

variable "additional_data_disks" {
  description = "Adding additional disks capacity to add each instance (GB)"
  type        = list(number)
  default     = []
}

variable "additional_data_disks_storage_account_type" {
  type        = string
  description = "The Type of Storage Account which should back this Data Disk. Possible values include Standard_LRS, StandardSSD_LRS, Premium_LRS and UltraSSD_LRS."
  default     = "Standard_LRS"
}

variable "dns_servers" {
  description = "List of dns servers to use for network interface"
  default     = []
}

variable "enable_ip_forwarding" {
  type        = bool
  description = "Should IP Forwarding be enabled? Defaults to false"
  default     = false
}

variable "enable_accelerated_networking" {
  type        = bool
  description = "Should Accelerated Networking be enabled? Defaults to false."
  default     = false
}

variable "assign_public_ip_to_each_vm_in_vmss" {
  type        = bool
  description = "Create a virtual machine scale set that assigns a public IP address to each VM"
  default     = false
}

variable "public_ip_prefix_id" {
  description = "The ID of the Public IP Address Prefix from where Public IP Addresses should be allocated"
  default     = null
}

variable "rolling_upgrade_policy" {
  description = "Enabling automatic OS image upgrades on your scale set helps ease update management by safely and automatically upgrading the OS disk for all instances in the scale set."
  type = object({
    max_batch_instance_percent              = number
    max_unhealthy_instance_percent          = number
    max_unhealthy_upgraded_instance_percent = number
    pause_time_between_batches              = string
  })
  default = {
    max_batch_instance_percent              = 20
    max_unhealthy_instance_percent          = 20
    max_unhealthy_upgraded_instance_percent = 20
    pause_time_between_batches              = "PT0S"
  }
}

variable "enable_automatic_instance_repair" {
  type        = bool
  description = "Should the automatic instance repair be enabled on this Virtual Machine Scale Set?"
  default     = false
}

variable "grace_period" {
  type        = string
  description = "Amount of time (in minutes, between 30 and 90, defaults to 30 minutes) for which automatic repairs will be delayed."
  default     = "PT30M"
}

variable "managed_identity_type" {
  type        = string
  description = "The type of Managed Identity which should be assigned to the Linux Virtual Machine Scale Set. Possible values are `SystemAssigned`, `UserAssigned` and `SystemAssigned, UserAssigned`"
  default     = null
}

variable "managed_identity_ids" {
  type        = string
  description = " A list of User Managed Identity ID's which should be assigned to the Linux Virtual Machine Scale Set."
  default     = null
}

variable "winrm_protocol" {
  description = "Specifies the protocol of winrm listener. Possible values are `Http` or `Https`"
  default     = null
}

variable "key_vault_certificate_secret_url" {
  description = "The Secret URL of a Key Vault Certificate, which must be specified when `protocol` is set to `Https`"
  default     = null
}

variable "additional_unattend_content" {
  description = "The XML formatted content that is added to the unattend.xml file for the specified path and component."
  default     = null
}

variable "additional_unattend_content_setting" {
  description = "The name of the setting to which the content applies. Possible values are `AutoLogon` and `FirstLogonCommands`"
  default     = null
}

variable "enable_boot_diagnostics" {
  type        = bool
  description = "Should the boot diagnostics enabled?"
  default     = false
}

variable "storage_account_uri" {
  description = "The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor. Passing a `null` value will utilize a Managed Storage Account to store Boot Diagnostics."
  default     = null
}

variable "load_balancer_backend_address_pool_ids" {
  description = "Controls if public load balancer should be created"
  default     = null
}

variable "load_balancer_inbound_nat_rules_ids" {
  description = "Controls if public load balancer should be created"
  default     = null
}

variable "enable_proximity_placement_group" {
  type        = bool
  description = "Manages a proximity placement group for virtual machines, virtual machine scale sets and availability sets."
  default     = false
}

variable "enable_autoscale_for_vmss" {
  type        = bool
  description = "Manages a AutoScale Setting which can be applied to Virtual Machine Scale Sets"
  default     = false
}

variable "minimum_instances_count" {
  type        = string
  description = "The minimum number of instances for this resource. Valid values are between 0 and 1000"
  default     = null
}

variable "maximum_instances_count" {
  type        = string
  description = "The maximum number of instances for this resource. Valid values are between 0 and 1000"
  default     = ""
}

variable "scale_out_cpu_percentage_threshold" {
  description = "Specifies the threshold % of the metric that triggers the scale out action."
  default     = "80"
}

variable "scale_in_cpu_percentage_threshold" {
  type        = string
  description = "Specifies the threshold of the metric that triggers the scale in action."
  default     = "20"
}

variable "scaling_action_instances_number" {
  type        = string
  description = "The number of instances involved in the scaling action"
  default     = "1"
}

variable "subnet_id" {
  type        = string
  description = "Subnet Id for the vm scaleset"
  default     = null
}