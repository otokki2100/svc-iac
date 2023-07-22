resource "aws_route_table" "routing_public" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "routing-public"
  }
}

resource "aws_route" "route" {
  route_table_id         = aws_route_table.routing_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "association_public_a" {
  subnet_id      = aws_subnet.pub_a.id
  route_table_id = aws_route_table.routing_public.id
}

resource "aws_route_table_association" "association_public_b" {
  subnet_id      = aws_subnet.pub_b.id
  route_table_id = aws_route_table.routing_public.id
}

resource "aws_route_table_association" "association_public_c" {
  subnet_id      = aws_subnet.pub_c.id
  route_table_id = aws_route_table.routing_public.id
}
