# nat gw  for availability zone 1 a
resource "aws_eip" "nat1" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw1" {
  allocation_id = aws_eip.nat1.id
  subnet_id     = aws_subnet.main-public-1.id
  depends_on    = [aws_internet_gateway.main-gw]
}

# VPC setup for NAT
resource "aws_route_table" "main-private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw1.id
  }

  tags = {
    Name = "main-private-1"
  }
}

# route associations private
resource "aws_route_table_association" "main-private-1-a" {
  subnet_id      = aws_subnet.main-private-1.id
  route_table_id = aws_route_table.main-private.id
}

# resource "aws_route_table_association" "main-private-1-b" {
#   subnet_id      = aws_subnet.main-private-2.id
#   route_table_id = aws_route_table.main-private.id
# }

# resource "aws_route_table_association" "main-private-1-c" {
#   subnet_id      = aws_subnet.main-private-3.id
#   route_table_id = aws_route_table.main-private.id
# }




# nat gw  for availability zone 1b 
resource "aws_eip" "nat2" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw2" {
  allocation_id = aws_eip.nat2.id
  subnet_id     = aws_subnet.main-public-2.id
  depends_on    = [aws_internet_gateway.main-gw]
}

# VPC setup for NAT
resource "aws_route_table" "main-private2" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw2.id
  }

  tags = {
    Name = "main-private-2"
  }
}

# route associations private
# resource "aws_route_table_association" "main-private-1-a" {
#   subnet_id      = aws_subnet.main-private-1.id
#   route_table_id = aws_route_table.main-private.id
# }

resource "aws_route_table_association" "main-private-1-b" {
  subnet_id      = aws_subnet.main-private-2.id
  route_table_id = aws_route_table.main-private2.id
}

# resource "aws_route_table_association" "main-private-1-c" {
#   subnet_id      = aws_subnet.main-private-3.id
#   route_table_id = aws_route_table.main-private.id
# }


# nat gw  for availability zone 1 c
resource "aws_eip" "nat3" {
  vpc = true
}

resource "aws_nat_gateway" "nat-gw3" {
  allocation_id = aws_eip.nat3.id
  subnet_id     = aws_subnet.main-public-3.id
  depends_on    = [aws_internet_gateway.main-gw]
}

# VPC setup for NAT
resource "aws_route_table" "main-private3" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw3.id
  }

  tags = {
    Name = "main-private-3"
  }
}

# route associations private
# resource "aws_route_table_association" "main-private-1-a" {
#   subnet_id      = aws_subnet.main-private-1.id
#   route_table_id = aws_route_table.main-private.id
# }

# resource "aws_route_table_association" "main-private-1-b" {
#   subnet_id      = aws_subnet.main-private-2.id
#   route_table_id = aws_route_table.main-private.id
# }

resource "aws_route_table_association" "main-private-1-c" {
  subnet_id      = aws_subnet.main-private-3.id
  route_table_id = aws_route_table.main-private3.id
}


