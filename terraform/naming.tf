locals {
  project_suffix_dashed = join("-", [var.location_prefix, var.project_name])
  project_suffix        = join("", [var.location_prefix, var.project_name])
}