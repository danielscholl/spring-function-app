/*
.Synopsis
   Terraform Output
.DESCRIPTION
   This file holds the outputs for the Spring Java Function App.
*/

#########################################################
# OUTPUT
#########################################################

output "service_plan_name" {
  description = "The name of the service plan created"
  value       = azurerm_app_service_plan.svcplan.name
}

output "service_plan_kind" {
  description = "The kind of service plan created"
  value       = azurerm_app_service_plan.svcplan.kind
}

output "app_service_plan_id" {
  value = azurerm_app_service_plan.svcplan.id
}

output "storage_account_id" {
  description = "The ID of the storage account."
  value       = azurerm_storage_account.storage.id
}
