resource "aws_instance" "test" {
  ami           = "ami-022e1a32d3f742bd8"
  instance_type = "t3.micro"
  key_name      = aws_key_pair.rsa_keypair.key_name
  subnet_id     = aws_subnet.public.id
  private_ip    = "10.0.10.11"

  vpc_security_group_ids = [
    aws_security_group.sg_ec2.id
  ]

  root_block_device {
    volume_type = "gp3"
    volume_size = 100
    encrypted   = true
  }

  provisioner "file" {
    source      = "id_rsa"
    destination = "/home/ec2-user/.ssh/id_rsa"

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("id_rsa")
      host        = self.public_ip
    }
  }

  tags = {
    Name = "test"
  }
}

provider "aws" {}

output "public_ip" {
  value = aws_instance.test.public_ip
}

resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    Name = "vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public"
  }
}

resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "route-table-public"
  }
}

resource "aws_route" "route_public_igw" {
  route_table_id         = aws_route_table.route_table_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.route_table_public.id
}

resource "aws_security_group" "sg_ec2" {
  vpc_id      = aws_vpc.vpc.id
  name        = "ec2"
  description = "ec2"

  tags = {
    Name = "ec2"
  }
}

resource "aws_security_group_rule" "sg_ec2_rule_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_ec2.id
}

resource "aws_security_group_rule" "sg_ec2_rule_ingress_ssh" {
  type              = "ingress"
  from_port         = "22"
  to_port           = "22"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_ec2.id
}

resource "aws_key_pair" "rsa_keypair" {
  key_name   = "rsa_keypair"
  public_key = file("id_rsa.pub")
  tags = {
    Name = "rsa-keypair"
  }
}
