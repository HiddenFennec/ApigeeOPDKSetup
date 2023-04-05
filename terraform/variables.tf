variable "project_id" {
  default = "apigee-hybrid-378710"
}

variable "vpc_name" {
  default = "apigee-opdk"
}

variable "region" {
  default = "asia-east1"
}

variable "subnet_name" {
  default = "apigee"
}

variable "subnet_cidr" {
  default = "10.0.0.0/24"
}

variable "vm_prefix" {
  default = "apigee-instance"
}

variable "vm_count" {
  default = 5
}

variable "vm_machine_type" {
  default = "n2-standard-4"
}

variable "gcs_bucket" {
  default = "apigee-opdk-bainries"
}