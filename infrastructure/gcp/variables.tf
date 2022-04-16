// Common variables
variable "dns_enabled" {}
variable "domain_name" {}
variable "enable_airgapped" {}
variable "enable_external_database" {}
variable "enable_external_registry" {}
variable "enable_external_storage" {}
variable "labels" {}
variable "name_format" {}
variable "name_format_global" {}
variable "workspace_name" {}

// Provider-specific variables
variable "preemptible_nodes" {}
variable "project" {}
variable "region" {}
