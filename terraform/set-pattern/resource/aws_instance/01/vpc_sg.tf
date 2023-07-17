resource "aws_network_acl" "acl_01" {
  vpc_id = aws_vpc.vpc_01.id
  subnet_ids = [
    aws_subnet.public_01.id,
  ]

  tags = {
    Name = "acl_01"
  }
}

resource "aws_network_acl_rule" "rule_ingress" {
  network_acl_id = aws_network_acl.acl_01.id
  rule_number    = 100
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "rule_egress" {
  network_acl_id = aws_network_acl.acl_01.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

resource "aws_security_group" "sg_01" {
  vpc_id      = aws_vpc.vpc_01.id
  name        = "sg_01"
  description = "sg_01"

  tags = {
    Name = "sg_01"
  }
}

resource "aws_security_group_rule" "rule_01" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_01.id
}

resource "aws_security_group_rule" "rule_02" {
  type              = "ingress"
  from_port         = "22"
  to_port           = "22"
  protocol          = "tcp"
  cidr_blocks       = ["211.115.223.215/32", "203.248.23.128/25", "180.69.105.0/24", "180.71.24.0/24"]
  security_group_id = aws_security_group.sg_01.id
}

resource "aws_security_group_rule" "rule_03" {
  type              = "ingress"
  from_port         = "8080"
  to_port           = "8080"
  protocol          = "tcp"
  cidr_blocks       = ["211.115.223.215/32", "203.248.23.128/25", "180.69.105.0/24", "180.71.24.0/24"]
  security_group_id = aws_security_group.sg_01.id
}
