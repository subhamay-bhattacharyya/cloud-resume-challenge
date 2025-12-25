# --- root/aws/tf/root/backend.tf ---

terraform {
  cloud {
    organization = "subhamay-bhattacharyya-crc"

    workspaces {
      name = "cloud-resume-challenge-aws"
    }
  }
}