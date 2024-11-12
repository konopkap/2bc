# ingress_nginx.tf
variable "ingress_nginx_pip_name" {
  type        = string
  description = "Public IP for ingress nginx."
}

variable "resource_group_name" {
  type        = string
  description = "Target resource group to create resources into."

  default = "Patryk-Candidate"
}