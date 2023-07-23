output "ec2_public_ip" {
  value = aws_instance.test.public_ip
}

output "ec2_z_ssh" {
  value = "ssh ec2-user@${aws_instance.test.public_ip} -o StrictHostKeyChecking=no -i id_rsa"
}
