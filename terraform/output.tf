output "jumphost" {
  value = module.jumphost.internal_ip
}

output "svc_account" {
  value = module.service_account.email
}

output "apigee_nodes" {
  value = [for vm in module.vm : vm.internal_ip]
}

output "subdomains" {
  value = module.nip-development-hostname.subdomains
}

output "ip_address" {
  value = module.nip-development-hostname.ip_address
}

output "northbound_subdomains" {
  value = module.nip-development-hostname-northbound.subdomains
}