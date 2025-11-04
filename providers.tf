terraform {
  required_version = "~> 1.13.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.9.0" ## Enforce using version 7.5.x of provider
    }
  }

  backend "gcs" {
    bucket = "terraform-course-student-00-state"
    prefix = "/terraform/state/jenkins-test-01"
  }
}

provider "google" {
  project = var.gcp_project
  region  = var.region
  zone    = var.zone
  default_labels = {
    lab         = var.lab_number
    app_name    = var.app_name
    department  = var.department
    company     = var.company
    environment = var.environment
    cost_center = var.cost_center
    deployed_by = "terraform"
  }


}
