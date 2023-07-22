resource "aws_network_acl" "acl" {
  vpc_id = aws_vpc.vpc.id
  subnet_ids = [
    aws_subnet.pub_a.id,
    aws_subnet.pub_b.id,
    aws_subnet.pub_c.id,
  ]

  tags = {
    Name = "acl"
  }
}

resource "aws_network_acl_rule" "rule_ingress" {
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 100
  egress         = false
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "rule_egress" {
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 100
  egress         = true
  protocol       = "-1"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}
