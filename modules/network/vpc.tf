resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr    
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
      Name: "demo-vpc"
    }
  
}


# Define subnet configuration dynamiclly

resource "aws_subnet" "public1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public1_cidr
  map_public_ip_on_launch = true
  

  tags = {
    Name = "Public-1"
  }
}

resource "aws_subnet" "private1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "192.168.10.64/26"

  tags = {
    Name = "Private-1"
  }
}



# Create an Internet Gateway for public subnets
resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "DemoGateway"
  }
}

# Create a public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }

  tags = {
    Name = "Public Route Table"
  }
 
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id
}

