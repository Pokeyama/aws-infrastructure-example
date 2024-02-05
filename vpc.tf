# VPC
resource "aws_vpc" "example_vpc" {
  cidr_block = "172.50.0.0/16"

  tags = {
    Name = "vpc-example"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "example_igw" {
  vpc_id = aws_vpc.example_vpc.id

  tags = {
    Name = "example-igw"
  }
}

# Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.example_vpc.id

  tags = {
    Name = "example-route-table-public"
  }
}

# Route for Public Subnets
resource "aws_route" "public" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.example_igw.id
}
