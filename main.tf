terraform {
  required_version = ">= 1.0.0"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0, < 4.0.0"
    }
  }

  backend "gcs" {
    bucket = "tf-gitpod-self-hosted"
  }
}
