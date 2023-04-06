module "nip-development-hostname" {
  source             = "git::https://github.com/apigee/terraform-modules.git//modules/nip-development-hostname"
  project_id         = var.project_id
  address_name       = "apigee-external"
  subdomain_prefixes = ["apigee", "apigee-ui"]
}

resource "google_compute_network_endpoint_group" "neg" {
  name         = "apigee-ui-neg"
  network      = module.vpc.self_link
  subnetwork   = module.vpc.subnet_self_links["${var.region}/${var.subnet_name}"]
  default_port = "9000"
  zone         = "${var.region}-b"
}

resource "google_compute_network_endpoint" "default-endpoint" {
  network_endpoint_group = google_compute_network_endpoint_group.neg.name
  port                   = google_compute_network_endpoint_group.neg.default_port
  ip_address             = module.vm[0].internal_ip
  instance               = module.vm[0].instance.name
  zone                   = "${var.region}-b"
}

module "gce-lb-http" {
  source = "git::https://github.com/terraform-google-modules/terraform-google-lb-http//modules/dynamic_backends"
  # version           = "~> 4.4"

  project              = var.project_id
  name                 = "group-http-lb"
  create_address       = false
  address              = module.nip-development-hostname.ip_address
  enable_ipv6          = false
  http_forward         = false
  ssl                  = true
  use_ssl_certificates = true
  ssl_certificates = [
    module.nip-development-hostname.ssl_certificate
  ]
  backends = {
    default = {
      description             = null
      port                    = 9000
      protocol                = "HTTP"
      port_name               = "http"
      timeout_sec             = 10
      enable_cdn              = false
      custom_request_headers  = null
      custom_response_headers = null
      security_policy         = null
      compression_mode        = null

      connection_draining_timeout_sec = null
      session_affinity                = null
      affinity_cookie_ttl_sec         = null

      health_check = {
        check_interval_sec  = null
        timeout_sec         = null
        healthy_threshold   = null
        unhealthy_threshold = null
        request_path        = "/login"
        port                = 9000
        host                = null
        logging             = null
      }

      log_config = {
        enable      = true
        sample_rate = 1.0
      }

      groups = [
        {
          # Each node pool instance group should be added to the backend.
          group                        = google_compute_network_endpoint_group.neg.id
          balancing_mode               = "RATE"
          capacity_scaler              = null
          description                  = null
          max_connections              = null
          max_connections_per_instance = null
          max_connections_per_endpoint = null
          max_rate                     = 1000
          max_rate_per_instance        = null
          max_rate_per_endpoint        = null
          max_utilization              = null
        },
      ]

      iap_config = {
        enable               = false
        oauth2_client_id     = null
        oauth2_client_secret = null
      }
    }
  }
}