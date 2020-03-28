# Copyright 2019 The Berglas Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

variable "project" {
  type = string
}

provider "google" {
  project = var.project
}

output "url" {
  value = google_cloud_run_service.webapp.status[0].url
}

resource "google_cloud_run_service" "webapp" {
  name     = "webapp"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/playfulpanda/webapp"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  # Enable the run.googleapis.com API while initializing
  # with make init see comment above
  # depends_on = [google_project_service.run]
}

resource "google_cloud_run_service_iam_member" "allUsers" {
  service  = google_cloud_run_service.webapp.name
  location = google_cloud_run_service.webapp.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# Enable the run.googleapis.com API while initializing with make init
# instead of using the google_project_service terraform resource
# to prevent destroying it, when running make destroy
# See this issue for more details:
# https://github.com/hashicorp/terraform/issues/2253
# resource "google_project_service" "run" {
#   service = "run.googleapis.com"
# }
