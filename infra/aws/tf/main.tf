# --- root/aws/tf/root/main.tf ---


module "acm-certificate" {
  source                    = "./modules/acm-certificate"
  domain-name               = local.acm-certificate.domain-name
  subject-alternative-names = local.acm-certificate.subject-alternative-names
  project-name              = var.project-name
}


module "s3-bucket" {
  source            = "./modules/s3-bucket"
  s3-static-website = local.s3-static-website
  project-name      = var.project-name
}