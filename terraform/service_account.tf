module "service_account" {
  source        = "terraform-google-modules/service-accounts/google"
  version       = "~> 4.1.1"
  project_id    = var.project_id
  prefix        = "apigee-svc-account"
  names         = ["simple"]
  project_roles = ["${var.project_id}=>roles/owner"]
}