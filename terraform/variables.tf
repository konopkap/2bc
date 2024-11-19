# Common
variable "location" {
  type        = string
  description = "Target location of created resources."

  default = "North Europe"
}

variable "location_prefix" {
  type        = string
  description = "Location prefix used for naming."

  default = "ne"
}

variable "project_name" {
  type        = string
  description = "Name of the project used for naming."

  default = "patryk2bc"
}

variable "resource_group_name" {
  type        = string
  description = "Target resource group to create resources into."

  default = "Patryk-Candidate"
}

variable "tags" {
  type        = map(string)
  description = "Tags added to resources."

  default = {
    "managedByTerraform" = "true"
    "owner"              = "patryk@2bc"
  }
}

# aks.tf
variable "aks_adminusername" {
  type        = string
  description = "Name of admin user of created Azure VM."

  default = "patryk2bc"
}

variable "aks_node_count" {
  type        = number
  description = "Number of nodes in the pool."

  validation {
    condition     = var.aks_node_count > 0
    error_message = "Node count must be positive!"
  }
  default = 2
}

variable "aks_node_size" {
  type        = string
  description = "Size of Azure VMs used to host AKS."

  default = "Standard_B2s"
}

variable "aks_version" {
  type        = string
  description = "Version of kubernetes deployed to AKS."

  default = "1.29.9"
}

# helm.tf
variable "helm_sample_app_tag" {
  type = string
  description = "Tag used to deploy sample-app to AKS."
}

# vm.tf
variable "vm_adminusername" {
  type        = string
  description = "Name of admin user of created Azure VM."

  default = "patryk2bc"
}

variable "vm_size" {
  type        = string
  description = "Size of Azure VM."

  default = "Standard_B2s"
}
