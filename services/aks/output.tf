output "name" {
  value       = module.aks.name
  description = "Specifies the name of the AKS cluster."
}

output "id" {
  value       = module.aks.id
  description = "Specifies the resource id of the AKS cluster."
}
