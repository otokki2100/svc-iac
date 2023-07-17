resource "aws_instance" "ec2_01" {
  ami                         = "ami-09e2a570cb404b37e" # CentOS 07
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.rsa_keypair.key_name
  subnet_id                   = aws_subnet.public_01.id
  private_ip                  = "10.0.10.11"
  associate_public_ip_address = "true"
  user_data                   = <<EOF
#!/bin/bash
echo "centos:password" | chpasswd
  EOF

  vpc_security_group_ids = [
    aws_security_group.sg_01.id
  ]

  root_block_device {
    volume_type = "gp3"
    volume_size = 100
    encrypted   = true
  }

  tags = {
    Name = "ec2_01"
  }
}
