# --- root/gcp/tf/backend.tf ---

terraform {
  cloud {

    organization = "subhamay-bhattacharyya-crc"

    workspaces {
      name = "cloud-resume-challenge-gcp"
    }
  }
}