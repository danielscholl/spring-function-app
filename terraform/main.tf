/*
.Synopsis
   Terraform Main Control
.DESCRIPTION
   This file holds the main control and resoures for the Terraform AKS Module.
*/

provider "azurerm" {
  version = "=1.36.0"
}

locals {
  unique           = "${random_integer.unique.result}"
  rg               = "${var.owner_initials}-function-java"
  storage_name     = "${var.owner_initials}storage${local.unique}"
  plan_name        = "${var.owner_initials}-plan${local.unique}"
  functionapp_name = "${var.owner_initials}-function-java${local.unique}"
}

#########################################################
# RESOURCES
#########################################################

resource "random_integer" "unique" {
  # 3 Digit Random Number Generator
  min = 100
  max = 999
}

#-------------------------------
# Resource Group
#-------------------------------
resource "azurerm_resource_group" "rg" {
  name     = "${local.rg}"
  location = "${var.location}"

  tags = {
    environment = "dev"
    contact     = "${var.owner_initials}"
  }
}

#-------------------------------
# Storage Account
#-------------------------------
resource "azurerm_storage_account" "storage" {
  name                = "${local.storage_name}"
  location            = "${azurerm_resource_group.rg.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  account_tier             = "Standard"
  account_replication_type = "LRS"

  # optional
  account_kind              = "Storage"
  enable_https_traffic_only = false
  account_encryption_source = "Microsoft.Storage"

  tags = {
    environment = "dev"
    contact     = "${var.owner_initials}"
  }
}


#-------------------------------
# App Service Plan
#-------------------------------
resource "azurerm_app_service_plan" "svcplan" {
  name                = "${local.plan_name}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${azurerm_resource_group.rg.location}"
  kind                = "FunctionApp"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }

  tags = {
    environment = "dev"
    contact     = "${var.owner_initials}"
  }
}


#-------------------------------
# Function App
#-------------------------------
resource "azurerm_function_app" "functionapp" {
  name                = "${local.functionapp_name}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  location            = "${azurerm_resource_group.rg.location}"

  app_service_plan_id       = "${azurerm_app_service_plan.svcplan.id}"
  storage_connection_string = "${azurerm_storage_account.storage.primary_connection_string}"

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"    = "java"
    "FUNCTIONS_EXTENSION_VERSION" = "~2"
  }

  tags = {
    environment = "dev"
    contact     = "${var.owner_initials}"
  }
}

