module "jumphost" {
  #   count      = var.vm_count
  source     = "git::https://github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/compute-vm"
  project_id = var.project_id
  zone       = "${var.region}-b"
  name       = "${var.vm_prefix}-jump"
  network_interfaces = [{
    network    = module.vpc.self_link
    subnetwork = module.vpc.subnet_self_links["${var.region}/${var.subnet_name}"]
  }]
  boot_disk = {
    initialize_params = {
      image = "projects/centos-cloud/global/images/centos-7-v20230306"
      size  = 100
    }
  }
  service_account = module.service_account.email
  tags            = ["ssh"]
  instance_type   = "n2-standard-2"
  metadata = {
    startup-script = <<-EOF
      #! /bin/bash
      yum update
      yum install -y git rsync tree python3
      python3 -m pip install --upgrade pip
      python3 -m pip install google-auth
      yum install -y ansible
      curl -fsSL https://rpm.nodesource.com/setup_16.x | sudo bash -
      sudo yum install -y nodejs
    EOF
  }
}


module "vm" {
  count      = var.vm_count
  source     = "git::https://github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/compute-vm"
  project_id = var.project_id
  zone       = "${var.region}-b"
  name       = "${var.vm_prefix}-${count.index}"
  network_interfaces = [{
    network    = module.vpc.self_link
    subnetwork = module.vpc.subnet_self_links["${var.region}/${var.subnet_name}"]
  }]
  boot_disk = {
    initialize_params = {
      image = "projects/centos-cloud/global/images/centos-7-v20230306"
      size  = 100
    }
  }
  service_account = module.service_account.email
  tags            = ["ssh"]
  instance_type   = var.vm_machine_type

  metadata = {
    startup-script = <<-EOF
      #! /bin/bash
      yum update
      yum install -y git rsync tree python3
      python3 -m pip install --upgrade pip
    EOF
  }
}
