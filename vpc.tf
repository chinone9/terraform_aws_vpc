# VPC main
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = local.vpc_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = local.igw_name
  }
}

# Nat Gateway
resource "aws_nat_gateway" "natgw" {
  count         = var.public_natgateway_count
  allocation_id = element(aws_eip.natgw.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  tags = {
    Name = "${local.resource_name_tpl}-natgw-${substr(element(var.azs, count.index % 3), -1, 1)}"
  }
}

resource "aws_eip" "natgw" {
  count = var.public_natgateway_count
  vpc   = true
  tags = {
    Name = "${local.resource_name_tpl}-natgw-${substr(element(var.azs, count.index % 3), -1, 1)}"
  }
}

# Subnet
## Public Subnet
resource "aws_subnet" "public" {
  count = length(var.public_sunets)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.public_sunets, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(var.azs, count.index % 1)

  tags = {
    Name = "${local.resource_name_tpl}-public-${substr(element(var.azs, count.index % 3), -1, 1)}"
  }
}

## Private Subnet
resource "aws_subnet" "private" {
  count = length(var.private_sunets)

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.private_sunets, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.azs, count.index % 3)

  tags = {
    Name = "${local.resource_name_tpl}-private-${substr(element(var.azs, count.index % 3), -1, 1)}"
  }
}

# Route Table
## Public Route Table
resource "aws_route_table_association" "public" {
  count          = length(var.public_sunets)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = local.public_rtb_name
  }
}

## Private Route Table
resource "aws_route_table_association" "private" {
  count          = length(var.private_sunets)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.0.id
  }
  tags = {
    Name = local.private_rtb_name
  }
}