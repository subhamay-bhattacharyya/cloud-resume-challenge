# --- root/gcp/tf/modules/dns/main.tf ---

data "google_dns_managed_zone" "primary" {
  name = var.dns_config["managed_zone_name"]
}

resource "google_dns_record_set" "a_record" {
  name         = "resume.${var.dns_config["website_domain"]}."
  managed_zone = data.google_dns_managed_zone.primary.name
  type         = "A"
  ttl          = 300

  rrdatas = [
    var.dns_config["ipv4_address"]
  ]
}

# resource "google_dns_record_set" "aaaa_record" {
#   name         = "resume.${var.dns_config["website_domain"]}."
#   managed_zone = data.google_dns_managed_zone.primary.name
#   type         = "AAAA"
#   ttl          = 300

#   rrdatas = [
#     var.dns_config["ipv6_address"]
#   ]
# }
