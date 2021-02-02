terraform {
  backend "gcs" {
    bucket  = "casa-7c-50-terraform-state"
    prefix  = "traydn-desktop-app"
  }
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.3.2"
    }
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

provider "github" {
  token = var.GH
  owner = "737casa"
}

resource "github_repository" "traydn-desktop-app" {
  name        = "traydn-desktop-app"
  description = "ui app2"
  visibility  = "public"
}

resource "google_project" "traydn-desktop-app" {
  provider = google-beta
  project_id = "casa-7c-50-traydn-desktop-app"
  name       = "casa-7c-50-traydn-desktop-app"
  org_id     = "518786306281"
  billing_account = "019044-E9BD53-EB5AEE"
}

resource "google_project_service" "firebase" {
  provider = google-beta
  project = "casa-7c-50-traydn-desktop-app"
  service = "firebase.googleapis.com"
  disable_on_destroy = false
  depends_on  = [google_project.traydn-desktop-app]
}

resource "google_firebase_project" "traydn-desktop-app" {
  provider = google-beta
  project  = google_project.traydn-desktop-app.project_id
  depends_on  = [google_project_service.firebase]
}

