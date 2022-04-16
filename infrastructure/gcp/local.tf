locals {
  db          = "db-n1-standard-2"
  dns_enabled = var.domain_name != null
  region      = replace(var.region, "/(^|-)([a-z])([a-z]+)/", "$2") # Short code for region
  machine     = "n2-standard-4"
  nodes = [
    {
      name = "services"
      labels = {
        lookup(var.labels, "workload_meta")      = true
        lookup(var.labels, "workload_ide")       = true
        lookup(var.labels, "workspace_services") = true
        lookup(var.labels, "workspace_regular")  = true
        lookup(var.labels, "workspace_headless") = true
      }
    }
  ]
}
