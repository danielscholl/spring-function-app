/*
.Synopsis
   Terraform Variables
.DESCRIPTION
   This file holds the variables for Terraform AKS Module.
*/

#########################################################
# VARIABLES
#########################################################

variable "owner_initials" {
  type        = string
  description = "Resource Owner Initials."
}

variable "location" {
  type        = string
  description = "Location for the resource groups."
  default     = "eastus"
}

