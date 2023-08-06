resource "local_file" "ansible_inventory" {
  filename        = "./hosts"
  file_permission = "0600"
  content  = <<-EOT
all:
  hosts:
    ec2:
      ansible_host: ${module.ec2.public_ip}
      ansible_connection: ssh
      ansible_user: ${var.ec2.user}
      ansible_ssh_private_key_file: id_rsa
      ansible_ssh_common_args: "-o StrictHostKeyChecking=no"
  EOT
}

resource "local_file" "ansible_variables" {
  filename        = "ansible_variables.yml"
  file_permission = "0600"
  content         = <<-EOT
region: ${var.region}
myip: ${var.myip}
wiki_code_path_remote: ${var.wiki_code_path_remote}
instance_type: ${var.ec2.instance_type}
ami: ${var.ec2.ami}
user: ${var.ec2.user}
dist: ${var.ec2.dist}
domain: ${local.domain}
  EOT
}
