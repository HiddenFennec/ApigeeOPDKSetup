resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh-key" {
  content  = tls_private_key.ssh.private_key_pem
  filename = "${path.module}/ssh.key"
}

resource "google_compute_project_metadata" "default" {
  project = var.project_id
  metadata = {
    ssh-keys = <<EOF
     apigee:${tls_private_key.ssh.public_key_openssh}
    EOF
  }
}