resource "aws_vpc" "email_validator_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "email_validator_subnet" {
  vpc_id                  = aws_vpc.email_validator_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "email_validator_igw" {
  vpc_id = aws_vpc.email_validator_vpc.id
}

resource "aws_route_table" "email_validator_rt" {
  vpc_id = aws_vpc.email_validator_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.email_validator_igw.id
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.email_validator_subnet.id
  route_table_id = aws_route_table.email_validator_rt.id
}
