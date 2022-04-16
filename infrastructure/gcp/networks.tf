resource "google_compute_network" "container_network" {
  description                     = "Network to establish private connections between the container and any resources"
  name                            = format(var.name_format_global, "vnet")
  auto_create_subnetworks         = true
  routing_mode                    = "GLOBAL"
  delete_default_routes_on_create = false
}

resource "google_compute_subnetwork" "container_subnetwork" {
  name          = format(var.name_format_global, "subnetwork")
  ip_cidr_range = "10.2.0.0/16"
  region        = var.region
  network       = google_compute_network.container_network.self_link
}

###
# Managed DNS
###

resource "random_integer" "dns" {
  count = local.dns_enabled ? 1 : 0

  min = 10000
  max = 99999
}

resource "google_service_account" "dns" {
  count = local.dns_enabled ? 1 : 0

  account_id   = substr(format(var.name_format, random_integer.dns.0.result, "dns"), 0, 28)
  display_name = "gitpod-${var.workspace_name}-dns"
  description  = "Service account for ${var.workspace_name} CloudDNS"
}

resource "google_project_iam_member" "dns" {
  for_each = local.dns_enabled ? toset([
    "roles/dns.admin"
  ]) : []

  project = var.project
  member  = "serviceAccount:${google_service_account.dns.0.email}"
  role    = each.value
}

resource "google_service_account_key" "dns" {
  count = local.dns_enabled ? 1 : 0

  service_account_id = google_service_account.dns.0.id
}

resource "google_dns_managed_zone" "dns" {
  count = local.dns_enabled ? 1 : 0

  dns_name      = "${var.domain_name}."
  name          = format(var.name_format, random_integer.dns.0.result, "dns")
  description   = "Gitpod DNS"
  force_destroy = true
}
