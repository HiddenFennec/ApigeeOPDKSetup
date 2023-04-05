output "jumphost" {
  value = module.jumphost.internal_ip
}

output "svc_account" {
  value = module.service_account.email
}

output "apigee_nodes" {
  value = [for vm in module.vm : vm.internal_ip]
}