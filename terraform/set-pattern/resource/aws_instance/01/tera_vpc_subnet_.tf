resource "aws_subnet" "pub_a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.11.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "pub-a"
  }
}

resource "aws_subnet" "pub_b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.12.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "pub-b"
  }
}

resource "aws_subnet" "pub_c" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.13.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "pub-c"
  }
}
