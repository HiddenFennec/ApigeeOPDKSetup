data "template_file" "silent" {
  template = file("${path.module}/silent_config.tpl")
  vars = {
    IP1 = module.vm[0].internal_ip
    IP2 = module.vm[1].internal_ip
    IP3 = module.vm[2].internal_ip
    IP4 = module.vm[3].internal_ip
    IP5 = module.vm[4].internal_ip
  }
}

data "template_file" "ansible_hosts" {
  template = file("${path.module}/ansible_hosts.tpl")
  vars = {
    IP1 = module.vm[0].internal_ip
    IP2 = module.vm[1].internal_ip
    IP3 = module.vm[2].internal_ip
    IP4 = module.vm[3].internal_ip
    IP5 = module.vm[4].internal_ip
  }
}

resource "local_file" "ansible_hosts" {
  content  = data.template_file.ansible_hosts.rendered
  filename = "${path.module}/hosts"
}

resource "google_storage_bucket_object" "picture" {
  name    = "silent.conf"
  content = data.template_file.silent.rendered
  bucket  = var.gcs_bucket
}