resource "aws_security_group" "bastion" {
  vpc_id      = aws_vpc.vpc.id
  name        = "bastion"
  description = "bastion"

  tags = {
    Name = "bastion"
  }
}

resource "aws_security_group_rule" "rule_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.bastion.id
}

resource "aws_security_group_rule" "rule_ingress_ssh" {
  type              = "ingress"
  from_port         = "1"
  to_port           = "65535"
  protocol          = "tcp"
  cidr_blocks       = ["211.115.223.215/32", "203.248.23.128/25", "180.69.105.0/24", "180.71.24.0/24"]
  security_group_id = aws_security_group.bastion.id
}
