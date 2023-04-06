# IAC for setting up 5 Node Apige OPDK

## Pre-Requistes
* `terraform` -> `~v1.3.6`

## Running the IAC
### Steps
* Run terraform Code
* Copy Ansible code to jump host
* Run Ansible playbook

### Run Terraform Code

```
cd terraform
terraform init
terraform apply -auto-approve
```

### Copy Ansible code to jump host

#### Instructions
```
# Copy Generated SSH key
cp terraform/ssh.key ansible/

# Copy generate Ansbile inventory
cp terraform/hosts ansible/

# Copy all ansible code , keys and inventory to jump host
gcloud compute scp --zone "asia-east1-b" --tunnel-through-iap --project "apigee-hybrid-378710" --recurse ansible apigee-instance-jump:ansible

# SSH into jump host
gcloud compute ssh --zone "asia-east1-b" "apigee-instance-jump"  --tunnel-through-iap --project "apigee-hybrid-378710"

# run these inside the Jump Host
cp ~/ansible.ssh.key ~/.ssh/id_rsa
chmod 400 ~/.ssh/id_rsa

```

### Run Ansible playbook

#### Instructions
```

# SSH into jump host
gcloud compute ssh --zone "asia-east1-b" "apigee-instance-jump"  --tunnel-through-iap --project "apigee-hybrid-378710"

# verify node reachability
cd ansible
ansible all -m ping -i hosts

# Run playbook
ansible-playbook main.yml -i hosts
```