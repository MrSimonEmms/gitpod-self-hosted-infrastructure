provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
}

provider "google-beta" {
  project = var.gcp_project
  region  = var.gcp_region
}

variable "gcp_use_preemptible_nodes" {
  default     = true
  type        = bool
  description = "Use preemptible nodes for the Kubernetes clusters"
}

variable "gcp_project" {
  type        = string
  default     = "sje-self-hosted-playground"
  description = "GCP project name"
}

variable "gcp_region" {
  type        = string
  default     = "europe-west1"
  description = "Region to deploy the infrastructure to"
}
