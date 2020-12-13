terraform {
  backend gcs { }
}

provider "google" {
  project     = var.project
}

resource "google_dns_record_set" "custom_domain" {
  name = "www.sqrt26.com." 
  type = "CNAME"
  ttl = 60

  managed_zone = var.managed_zone

  rrdatas = ["femnad.github.io."]
}
