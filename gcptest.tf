//Variables

variable "image_id" {
  type = string
}

variable "project_id" {
  type = string
}

variable "project_name" {
  type = string
}

provider "google" {
  credentials = file("account.json")
  project     = var.project_id
}

resource "google_cloud_run_service" "default" {
  name     = var.project_name
  location = "europe-west1"

  traffic {
    percent         = 100
    latest_revision = true
  }

  template {
    spec {
      containers {
        image = var.image_id
      }
    }
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.default.location
  project  = google_cloud_run_service.default.project
  service  = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

