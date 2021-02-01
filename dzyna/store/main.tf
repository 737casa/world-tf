terraform {
  backend "gcs" {
    bucket  = "casa-7c-50-terraform-state"
    prefix  = "dzyna-store"
  }
  required_providers {
    google-beta = {
      version = "~> 3.45.0"
      source  = "hashicorp/google-beta"
    }

  }
}

provider "google-beta" {
  credentials = var.SERVICE_ACCOUNT
  project = "terraform-manager-001"
}

resource "google_project" "dzyna100" {
  provider = google-beta
  project_id = "casa-7c-50-dzyna100-store"
  name       = "casa-7c-50-dzyna100-store"
  org_id     = "518786306281"
  billing_account = "017DA3-399C11-B3174E"
}

resource "google_project_service" "firebase" {
  provider = google-beta
  project = "casa-7c-50-dzyna100-store"
  service = "firebase.googleapis.com"
  disable_on_destroy = false
  depends_on  = [google_project.dzyna100]
}

resource "google_firebase_project" "dzyna100" {
  provider = google-beta
  project  = google_project.dzyna100.project_id
  depends_on  = [google_project_service.firebase]
}