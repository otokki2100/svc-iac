output "domain" {
  value = local.domain
}

output "jenkins" {
  value = "http://${local.domain}:8080"
}

output "vm_info_id" {
  value = module.ec2.id
}

output "vm_info_instance_type" {
  value = var.ec2.instance_type
}

output "vm_ssh_1_user" {
  value = var.ec2.user
}

output "vm_ssh_2_ip" {
  value = module.ec2.public_ip
}

output "vm_ssh_3_ssh" {
  value = "ssh ${var.ec2.user}@${module.ec2.public_ip} -o StrictHostKeyChecking=no -i id_rsa"
}
