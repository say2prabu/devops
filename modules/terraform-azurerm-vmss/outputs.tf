output "linux_virtual_machine_scale_set_name" {
  description = "The name of the Linux Virtual Machine Scale Set."
  value       = var.os_flavor == "linux" ? element(concat(azurerm_linux_virtual_machine_scale_set.linux_vmss.*.name, [""]), 0) : null
}

output "linux_virtual_machine_scale_set_id" {
  description = "The resource ID of the Linux Virtual Machine Scale Set."
  value       = var.os_flavor == "linux" ? element(concat(azurerm_linux_virtual_machine_scale_set.linux_vmss.*.id, [""]), 0) : null
}

output "linux_virtual_machine_scale_set_unique_id" {
  description = "The unique ID of the Linux Virtual Machine Scale Set."
  value       = var.os_flavor == "linux" ? element(concat(azurerm_linux_virtual_machine_scale_set.linux_vmss.*.unique_id, [""]), 0) : null
}

output "windows_virtual_machine_scale_set_name" {
  description = "The name of the windows Virtual Machine Scale Set."
  value       = var.os_flavor == "windows" ? element(concat(azurerm_windows_virtual_machine_scale_set.winsrv_vmss.*.name, [""]), 0) : null
}

output "windows_virtual_machine_scale_set_id" {
  description = "The resource ID of the windows Virtual Machine Scale Set."
  value       = var.os_flavor == "windows" ? element(concat(azurerm_windows_virtual_machine_scale_set.winsrv_vmss.*.id, [""]), 0) : null
}

output "windows_virtual_machine_scale_set_unique_id" {
  description = "The unique ID of the windows Virtual Machine Scale Set."
  value       = var.os_flavor == "windows" ? element(concat(azurerm_windows_virtual_machine_scale_set.winsrv_vmss.*.unique_id, [""]), 0) : null
}