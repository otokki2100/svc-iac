resource "aws_subnet" "public_01" {
  vpc_id                  = aws_vpc.vpc_01.id
  cidr_block              = "10.0.10.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public_01"
  }
}

resource "aws_route_table" "routing_public_01" {
  vpc_id = aws_vpc.vpc_01.id

  tags = {
    Name = "routing_public_01"
  }
}

resource "aws_route" "route_01" {
  route_table_id         = aws_route_table.routing_public_01.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw_01.id
}

resource "aws_route_table_association" "association_01" {
  subnet_id      = aws_subnet.public_01.id
  route_table_id = aws_route_table.routing_public_01.id
}
