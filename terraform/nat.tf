module "nat" {
  source         = "git::https://github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/net-cloudnat"
  project_id     = var.project_id
  region         = var.region
  name           = "default"
  router_network = module.vpc.name
}