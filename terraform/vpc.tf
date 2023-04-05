module "vpc" {
  source     = "git::https://github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/net-vpc"
  project_id = var.project_id
  name       = var.vpc_name
  subnets = [
    {
      ip_cidr_range = var.subnet_cidr
      name          = var.subnet_name
      region        = var.region
    }
  ]
}
# tftest modules=1 resources=3 inventory=simple.yaml