/*
* ## terraform-azurerm-vmss
* Terraform module to create a Azure virutal machine scale sets for windows as well as Linux
* 
* ## Description
* Azure virtual machine scale sets let you create and manage a group of load balanced VMs. The number of VM instances can automatically increase or decrease in response to demand or a defined schedule. 
* Scale sets provide high availability to your applications, and allow you to centrally manage, configure, and update a large number of VMs.
*  You can deploy a windows vm scaleset or linux vm scaleset using below module
* You can deploy vm scale sets behind a load balancer or without load blancer also
* If you would like to deploy the vm scale set behind a load blancer, load balancer should exist already and you should pass load balancer backend pool and optionally load balancer nat pool
* Various options have been parametersied and optional for example : data disks, automatic_os_upgrade_policy, rolling_upgrade_policy, automatic instance repair etc
* ## Dependencies
* Virtual Network and Subnet
* Network Security Group
* ## Module example use
* ```hcl
* windows example
* module "vmss_win" {
*  source = "../../modules/terraform-azurerm-vmss"
*  resource_group_name  = azurerm_resource_group.main.name
*  location             = azurerm_resource_group.main.location
*  subnet_id            = data.azurerm_subnet.snet.id
*  vmscaleset_name      = module.naming.vm_scaleset.name
*  tags = var.tags
*  os_flavor                 = "windows"
*  windows_distribution_name = "windows2019dc"
*  virtual_machine_size      = "Standard_A2_v2"
*  computer_name_prefix      = "atosvm"
*  admin_username            = "azureadmin"
*  admin_password            = "P@$$w0rd1234!"
*  instances_count           = 2
*  existing_network_security_group_id = azurerm_network_security_group.main.id
*  load_balancer_backend_address_pool_ids = [data.azurerm_lb_backend_address_pool.main.id]  
*  # Enable Auto scaling feature for VM scaleset by set argument to true. 
*  # Instances_count in VMSS will become default and minimum instance count.
*  # Automatically scale out the number of VM instances based on CPU Average only.    
*  enable_autoscale_for_vmss          = true
*  minimum_instances_count            = 2
*  maximum_instances_count            = 5
*  scale_out_cpu_percentage_threshold = 80
*  scale_in_cpu_percentage_threshold  = 20
*
*}
*
*Linux examples
*module "vmss_linux" {
*  source              = "../../modules/terraform-azurerm-vmss"
*  resource_group_name = azurerm_resource_group.main.name
*  location            = azurerm_resource_group.main.location
*  subnet_id           = data.azurerm_subnet.snet.id
*  vmscaleset_name     = module.naming.vm_scaleset.name
*  tags                = var.tags
*
*  os_flavor                              = "linux"
*  linux_distribution_name                = "ubuntu1804"
*  virtual_machine_size                   = "Standard_A2_v2"
*  admin_username                         = "azureadmin"
*  admin_password                         = "P@$$w0rd1234!"
*  generate_admin_ssh_key                 = true
*  instances_count                        = 2
*  existing_network_security_group_id     = azurerm_network_security_group.main.id
*  load_balancer_backend_address_pool_ids = [data.azurerm_lb_backend_address_pool.main.id]
*
*  # Enable Auto scaling feature for VM scaleset by set argument to true. 
*  # Instances_count in VMSS will become default and minimum instance count.
*  # Automatically scale out the number of VM instances based on CPU Average only.    
*  enable_autoscale_for_vmss          = true
*  minimum_instances_count            = 2
*  maximum_instances_count            = 5
*  scale_out_cpu_percentage_threshold = 80
*  scale_in_cpu_percentage_threshold  = 20
*
*}
*
* ```
*
* ## License
* Atos, all rights protected - 2021.
*/


#----------------------------------------------------------------------------------------------------
# Proximity placement group for virtual machines, virtual machine scale sets and availability sets.
#----------------------------------------------------------------------------------------------------
resource "azurerm_proximity_placement_group" "appgrp" {
  count               = var.enable_proximity_placement_group ? 1 : 0
  name                = lower("${var.vmscaleset_name}-proxigrp")
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
}

#---------------------------------------
# Linux Virutal machine scale set
#---------------------------------------
resource "azurerm_linux_virtual_machine_scale_set" "linux_vmss" {
  count                                             = var.os_flavor == "linux" ? 1 : 0
  name                                              = var.vmscaleset_name
  computer_name_prefix                              = var.computer_name_prefix
  resource_group_name                               = var.resource_group_name
  location                                          = var.location
  sku                                               = var.virtual_machine_size
  instances                                         = var.instances_count
  admin_username                                    = var.admin_username
  admin_password                                    = var.admin_password
  custom_data                                       = var.custom_data
  disable_password_authentication                   = var.disable_password_authentication
  overprovision                                     = var.overprovision
  do_not_run_extensions_on_overprovisioned_machines = var.do_not_run_extensions_on_overprovisioned_machines
  encryption_at_host_enabled                        = var.enable_encryption_at_host
  #health_probe_id                                   = var.enable_load_balancer #? azurerm_lb_probe.lbp[0].id : null
  platform_fault_domain_count  = var.platform_fault_domain_count
  provision_vm_agent           = true
  proximity_placement_group_id = var.enable_proximity_placement_group ? azurerm_proximity_placement_group.appgrp.0.id : null
  scale_in_policy              = var.scale_in_policy
  single_placement_group       = var.single_placement_group
  source_image_id              = var.source_image_id != null ? var.source_image_id : null
  upgrade_mode                 = var.os_upgrade_mode
  zones                        = var.availability_zones
  zone_balance                 = var.availability_zone_balance
  tags                         = var.tags

  dynamic "admin_ssh_key" {
    for_each = var.disable_password_authentication ? [1] : []
    content {
      username   = var.admin_username
      public_key = var.admin_ssh_key_data == null ? tls_private_key.rsa[0].public_key_openssh : file(var.admin_ssh_key_data)
    }
  }

  dynamic "source_image_reference" {
    for_each = var.source_image_id != null ? [] : [1]
    content {
      publisher = var.custom_image != null ? var.custom_image["publisher"] : var.linux_distribution_list[lower(var.linux_distribution_name)]["publisher"]
      offer     = var.custom_image != null ? var.custom_image["offer"] : var.linux_distribution_list[lower(var.linux_distribution_name)]["offer"]
      sku       = var.custom_image != null ? var.custom_image["sku"] : var.linux_distribution_list[lower(var.linux_distribution_name)]["sku"]
      version   = var.custom_image != null ? var.custom_image["version"] : var.linux_distribution_list[lower(var.linux_distribution_name)]["version"]
    }
  }

  os_disk {
    storage_account_type      = var.os_disk_storage_account_type
    caching                   = var.os_disk_caching
    disk_encryption_set_id    = var.disk_encryption_set_id
    disk_size_gb              = var.disk_size_gb
    write_accelerator_enabled = var.enable_os_disk_write_accelerator
  }

  dynamic "additional_capabilities" {
    for_each = var.enable_ultra_ssd_data_disk_storage_support ? [1] : []
    content {
      ultra_ssd_enabled = var.enable_ultra_ssd_data_disk_storage_support
    }
  }

  dynamic "data_disk" {
    for_each = var.additional_data_disks
    content {
      lun                  = data_disk.key
      disk_size_gb         = data_disk.value
      caching              = "ReadWrite"
      create_option        = "Empty"
      storage_account_type = var.additional_data_disks_storage_account_type
    }
  }

  network_interface {
    name                          = lower("nic-${format("vm%s%s", lower(replace(var.vmscaleset_name, "/[[:^alnum:]]/", "")), count.index + 1)}")
    primary                       = true
    dns_servers                   = var.dns_servers
    enable_ip_forwarding          = var.enable_ip_forwarding
    enable_accelerated_networking = var.enable_accelerated_networking
    network_security_group_id     = var.existing_network_security_group_id #== null ? azurerm_network_security_group.nsg.0.id : var.existing_network_security_group_id

    ip_configuration {
      name                                   = lower("ipconig-${format("vm%s%s", lower(replace(var.vmscaleset_name, "/[[:^alnum:]]/", "")), count.index + 1)}")
      primary                                = true
      subnet_id                              = var.subnet_id
      load_balancer_backend_address_pool_ids = var.load_balancer_backend_address_pool_ids != null ? var.load_balancer_backend_address_pool_ids : null
      load_balancer_inbound_nat_rules_ids    = var.load_balancer_backend_address_pool_ids != null && var.load_balancer_inbound_nat_rules_ids != null ? var.load_balancer_inbound_nat_rules_ids : null

      dynamic "public_ip_address" {
        for_each = var.assign_public_ip_to_each_vm_in_vmss ? [1] : []
        content {
          name                = lower("pip-${format("vm%s%s", lower(replace(var.vmscaleset_name, "/[[:^alnum:]]/", "")), "0${count.index + 1}")}")
          public_ip_prefix_id = var.public_ip_prefix_id
        }
      }
    }
  }

  dynamic "automatic_os_upgrade_policy" {
    for_each = var.os_upgrade_mode == "Automatic" ? [1] : []
    content {
      disable_automatic_rollback  = true
      enable_automatic_os_upgrade = true
    }
  }

  dynamic "rolling_upgrade_policy" {
    for_each = var.os_upgrade_mode != "Manual" ? [1] : []
    content {
      max_batch_instance_percent              = var.rolling_upgrade_policy.max_batch_instance_percent
      max_unhealthy_instance_percent          = var.rolling_upgrade_policy.max_unhealthy_instance_percent
      max_unhealthy_upgraded_instance_percent = var.rolling_upgrade_policy.max_unhealthy_upgraded_instance_percent
      pause_time_between_batches              = var.rolling_upgrade_policy.pause_time_between_batches
    }
  }

  dynamic "automatic_instance_repair" {
    for_each = var.enable_automatic_instance_repair ? [1] : []
    content {
      enabled      = var.enable_automatic_instance_repair
      grace_period = var.grace_period
    }
  }

  dynamic "identity" {
    for_each = var.managed_identity_type != null ? [1] : []
    content {
      type         = var.managed_identity_type
      identity_ids = var.managed_identity_type == "UserAssigned" || var.managed_identity_type == "SystemAssigned, UserAssigned" ? var.managed_identity_ids : null
    }
  }

  dynamic "boot_diagnostics" {
    for_each = var.enable_boot_diagnostics ? [1] : []
    content {
      storage_account_uri = var.storage_account_uri
    }
  }

  lifecycle {
    ignore_changes = [
      tags,
      automatic_instance_repair,
      automatic_os_upgrade_policy,
      rolling_upgrade_policy,
      instances,
      data_disk,
    ]
  }

}

#---------------------------------------
# Windows Virutal machine scale set
#---------------------------------------
resource "azurerm_windows_virtual_machine_scale_set" "winsrv_vmss" {
  count                                             = var.os_flavor == "windows" ? 1 : 0
  name                                              = var.vmscaleset_name
  computer_name_prefix                              = var.computer_name_prefix
  resource_group_name                               = var.resource_group_name
  location                                          = var.location
  sku                                               = var.virtual_machine_size
  instances                                         = var.instances_count
  admin_username                                    = var.admin_username
  admin_password                                    = var.admin_password
  custom_data                                       = var.custom_data
  overprovision                                     = var.overprovision
  do_not_run_extensions_on_overprovisioned_machines = var.do_not_run_extensions_on_overprovisioned_machines
  enable_automatic_updates                          = var.os_upgrade_mode != "Automatic" ? var.enable_windows_vm_automatic_updates : false
  encryption_at_host_enabled                        = var.enable_encryption_at_host
  #health_probe_id                                   = var.enable_load_balancer #? azurerm_lb_probe.lbp[0].id : null
  license_type                 = var.license_type
  platform_fault_domain_count  = var.platform_fault_domain_count
  provision_vm_agent           = true
  proximity_placement_group_id = var.enable_proximity_placement_group ? azurerm_proximity_placement_group.appgrp.0.id : null
  scale_in_policy              = var.scale_in_policy
  single_placement_group       = var.single_placement_group
  source_image_id              = var.source_image_id != null ? var.source_image_id : null
  upgrade_mode                 = var.os_upgrade_mode
  timezone                     = var.vm_time_zone
  zones                        = var.availability_zones
  zone_balance                 = var.availability_zone_balance
  tags                         = var.tags

  dynamic "source_image_reference" {
    for_each = var.source_image_id != null ? [] : [1]
    content {
      publisher = var.custom_image != null ? var.custom_image["publisher"] : var.windows_distribution_list[lower(var.windows_distribution_name)]["publisher"]
      offer     = var.custom_image != null ? var.custom_image["offer"] : var.windows_distribution_list[lower(var.windows_distribution_name)]["offer"]
      sku       = var.custom_image != null ? var.custom_image["sku"] : var.windows_distribution_list[lower(var.windows_distribution_name)]["sku"]
      version   = var.custom_image != null ? var.custom_image["version"] : var.windows_distribution_list[lower(var.windows_distribution_name)]["version"]
    }
  }

  os_disk {
    storage_account_type      = var.os_disk_storage_account_type
    caching                   = var.os_disk_caching
    disk_encryption_set_id    = var.disk_encryption_set_id
    disk_size_gb              = var.disk_size_gb
    write_accelerator_enabled = var.enable_os_disk_write_accelerator
  }

  dynamic "additional_capabilities" {
    for_each = var.enable_ultra_ssd_data_disk_storage_support ? [1] : []
    content {
      ultra_ssd_enabled = var.enable_ultra_ssd_data_disk_storage_support
    }
  }

  dynamic "data_disk" {
    for_each = var.additional_data_disks
    content {
      lun                  = data_disk.key
      disk_size_gb         = data_disk.value
      caching              = "ReadWrite"
      create_option        = "Empty"
      storage_account_type = var.additional_data_disks_storage_account_type
    }
  }

  network_interface {
    name                          = lower("nic-${format("vm%s%s", lower(replace(var.vmscaleset_name, "/[[:^alnum:]]/", "")), count.index + 1)}")
    primary                       = true
    dns_servers                   = var.dns_servers
    enable_ip_forwarding          = var.enable_ip_forwarding
    enable_accelerated_networking = var.enable_accelerated_networking
    network_security_group_id     = var.existing_network_security_group_id

    ip_configuration {
      name                                   = lower("ipconfig-${format("vm%s%s", lower(replace(var.vmscaleset_name, "/[[:^alnum:]]/", "")), count.index + 1)}")
      primary                                = true
      subnet_id                              = var.subnet_id
      load_balancer_backend_address_pool_ids = var.load_balancer_backend_address_pool_ids != null ? var.load_balancer_backend_address_pool_ids : null
      load_balancer_inbound_nat_rules_ids    = var.load_balancer_backend_address_pool_ids != null && var.load_balancer_inbound_nat_rules_ids != null ? var.load_balancer_inbound_nat_rules_ids : null

      dynamic "public_ip_address" {
        for_each = var.assign_public_ip_to_each_vm_in_vmss ? [{}] : []
        content {
          name                = lower("pip-${format("vm%s%s", lower(replace(var.vmscaleset_name, "/[[:^alnum:]]/", "")), count.index + 1)}")
          public_ip_prefix_id = var.public_ip_prefix_id
        }
      }
    }
  }

  dynamic "automatic_os_upgrade_policy" {
    for_each = var.os_upgrade_mode == "Automatic" ? [1] : []
    content {
      disable_automatic_rollback  = true
      enable_automatic_os_upgrade = true
    }
  }

  dynamic "rolling_upgrade_policy" {
    for_each = var.os_upgrade_mode != "Manual" ? [1] : []
    content {
      max_batch_instance_percent              = var.rolling_upgrade_policy.max_batch_instance_percent
      max_unhealthy_instance_percent          = var.rolling_upgrade_policy.max_unhealthy_instance_percent
      max_unhealthy_upgraded_instance_percent = var.rolling_upgrade_policy.max_unhealthy_upgraded_instance_percent
      pause_time_between_batches              = var.rolling_upgrade_policy.pause_time_between_batches
    }
  }

  dynamic "automatic_instance_repair" {
    for_each = var.enable_automatic_instance_repair ? [1] : []
    content {
      enabled      = var.enable_automatic_instance_repair
      grace_period = var.grace_period
    }
  }

  dynamic "identity" {
    for_each = var.managed_identity_type != null ? [1] : []
    content {
      type         = var.managed_identity_type
      identity_ids = var.managed_identity_type == "UserAssigned" || var.managed_identity_type == "SystemAssigned, UserAssigned" ? var.managed_identity_ids : null
    }
  }

  dynamic "winrm_listener" {
    for_each = var.winrm_protocol != null ? [1] : []
    content {
      protocol        = var.winrm_protocol
      certificate_url = var.winrm_protocol == "Https" ? var.key_vault_certificate_secret_url : null
    }
  }

  dynamic "additional_unattend_content" {
    for_each = var.additional_unattend_content != null ? [1] : []
    content {
      content = var.additional_unattend_content
      setting = var.additional_unattend_content_setting
    }
  }

  dynamic "boot_diagnostics" {
    for_each = var.enable_boot_diagnostics ? [1] : []
    content {
      storage_account_uri = var.storage_account_name != null ? data.azurerm_storage_account.storeacc.0.primary_blob_endpoint : var.storage_account_uri
    }
  }

  lifecycle {
    ignore_changes = [
      tags,
      automatic_instance_repair,
      automatic_os_upgrade_policy,
      rolling_upgrade_policy,
      instances,
      winrm_listener,
      additional_unattend_content,
      data_disk,
    ]
  }
}

#-----------------------------------------------
# Auto Scaling for Virtual machine scale set
#-----------------------------------------------
resource "azurerm_monitor_autoscale_setting" "auto" {
  count               = var.enable_autoscale_for_vmss ? 1 : 0
  name                = lower("${var.vmscaleset_name}-auto-scale-set")
  resource_group_name = var.resource_group_name
  location            = var.location
  target_resource_id  = var.os_flavor == "windows" ? azurerm_windows_virtual_machine_scale_set.winsrv_vmss.0.id : azurerm_linux_virtual_machine_scale_set.linux_vmss.0.id

  profile {
    name = "default"
    capacity {
      default = var.instances_count
      minimum = var.minimum_instances_count == null ? var.instances_count : var.minimum_instances_count
      maximum = var.maximum_instances_count
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = var.os_flavor == "windows" ? azurerm_windows_virtual_machine_scale_set.winsrv_vmss.0.id : azurerm_linux_virtual_machine_scale_set.linux_vmss.0.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = var.scale_out_cpu_percentage_threshold
      }
      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = var.scaling_action_instances_number
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = var.os_flavor == "windows" ? azurerm_windows_virtual_machine_scale_set.winsrv_vmss.0.id : azurerm_linux_virtual_machine_scale_set.linux_vmss.0.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = var.scale_in_cpu_percentage_threshold
      }
      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = var.scaling_action_instances_number
        cooldown  = "PT1M"
      }
    }
  }
}
