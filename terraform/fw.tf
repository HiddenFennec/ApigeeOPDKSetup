module "firewall" {
  source     = "git::https://github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/net-vpc-firewall"
  project_id = var.project_id
  network    = module.vpc.name
  default_rules_config = {
    admin_ranges = ["10.0.0.0/8"]
  }
  ingress_rules = {
    # implicit allow action
    allow-ingress-ntp = {
      description = "Allow SSH to all."
      rules       = [{ protocol = "tcp", ports = [22] }]
    }
    allow-ingress-icmp = {
      description = "Allow ICMP to all."
      rules       = [{ protocol = "icmp" }]
    },
    allow-interal-all = {
      description   = "Allow ICMP to all."
      source_ranges = [var.subnet_cidr]
      rules = [
        { protocol = "icmp" },
        { protocol = "tcp", ports = ["0-65535"] },
        { protocol = "udp", ports = ["0-65535"] }
      ]
    },
    allow-fw = {
      description   = "Allow healthcheck to all."
      source_ranges = ["35.191.0.0/16", "130.211.0.0/22"]
      targets       = ["allow-health-checks"]
      rules = [
        { protocol = "tcp", ports = ["9000","8080"] },
        { protocol = "tcp", ports = ["9001-9099"] }
      ]
    }
  }
}
# tftest modules=1 resources=9