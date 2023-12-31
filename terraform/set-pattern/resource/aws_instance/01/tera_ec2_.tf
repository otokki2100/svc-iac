resource "aws_instance" "ec2" {
  ami                         = "ami-022e1a32d3f742bd8" # amazl 2023
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.rsa_keypair_new.key_name
  subnet_id                   = aws_subnet.pub_a.id
  private_ip                  = "10.0.11.11"
  associate_public_ip_address = "true"
  # user_data = file("script.sh")
  user_data                   = <<EOF
#!/bin/bash
echo "ec2-user:password" | chpasswd
echo "root:password" | chpasswd

sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl restart sshd

hostnamectl set-hostname ec2
  EOF

  vpc_security_group_ids = [
    aws_security_group.bastion.id
  ]

  root_block_device {
    volume_type = "gp3"
    volume_size = 100
    encrypted   = true
  }

  tags = {
    Name = "ec2"
  }
}
