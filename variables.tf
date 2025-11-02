### ===================== GCP =================
variable "gcp_project" {
  type        = string
  description = "Project for tagging purposes"
}

variable "region" {
  type        = string
  description = "GCP region to deploy VM"
  default     = "europe-southwest1"

}

variable "zone" {
  type        = string
  description = "GCP zone to deploy VM"
  default     = "europe-southwest1-a"
}
### ===================== Course, Company and Environment =================

variable "lab_number" {
  type        = string
  description = "Lab number - sometimes help for resource uniqueness"
}
variable "company" {
  type        = string
  description = "Company name for tagging purposes"
}

variable "department" {
  type        = string
  description = "Department name for tagging purposes"
  validation {
    condition     = var.department == "mdr" || var.department == "oad" || var.department == "sec"
    error_message = "The department must be one of 'mdr', 'oad', or 'sec'."
  }
}

variable "environment" {
  type        = string
  description = "Environment for tagging purposes"
  default     = "dev"
  ## Add validation for allowed values
  validation {
    condition     = contains(["dev", "staging", "prod", "shared"], var.environment)
    error_message = "The environment must be one of 'dev', 'staging', 'prod', or 'shared'."
  }
}

variable "app_name" {
  type        = string
  description = "Application name for tagging purposes"
  default     = "web"
  validation {
    condition     = contains(["mdr", "web", "api", "db", "cache"], var.app_name)
    error_message = "The app_name must be one of 'mdr','web', 'api', 'db', or 'cache'."
  }
}

variable "cost_center" {
  type        = string
  description = "Cost center for tagging purposes"
  default     = "12345"
  validation {
    condition     = can(regex("^[0-9]{5}$", var.cost_center))
    error_message = "The cost_center must be a 5-digit number."
  }
}


###
variable "machine_type" {
  type        = string
  description = "Machine type for the VM"
  validation {
    condition     = contains(["e2-medium", "n1-standard-1", "n1-standard-2", "n1-standard-4", "n1-standard-8", "n1-standard-16", "n1-standard-32", "n1-standard-64"], var.machine_type)
    error_message = "The machine_type must be one of 'e2-medium', 'n1-standard-1', 'n1-standard-2', 'n1-standard-4', 'n1-standard-8', 'n1-standard-16', 'n1-standard-32', 'n1-standard-64'."
  }
}

