#VPC
resource "aws_vpc" "vpc_threatapp" {
    cidr_block = var.vpc_cidrblock  
}

#IGW
resource "aws_internet_gateway" "igw_threatapp" {
    vpc_id = aws_vpc.vpc_threatapp.id
}

#Subnets
resource "aws_subnet" "public_subnet_1" {
    vpc_id = aws_vpc.vpc_threatapp.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "eu-west-2a"
}

resource "aws_subnet" "public_subnet_2" {
    vpc_id = aws_vpc.vpc_threatapp.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = true
    availability_zone = "eu-west-2b"
}

resource "aws_subnet" "private_subnet_1" {
    vpc_id = aws_vpc.vpc_threatapp.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "eu-west-2a"
}

resource "aws_subnet" "private_subnet_2" {
    vpc_id = aws_vpc.vpc_threatapp.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "eu-west-2b"
}


#NAT Gateway
resource "aws_eip" "nat_eip" {
    domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway_threatapp" {
    availability_mode = "regional"
    allocation_id = aws_eip.nat_eip.id
    vpc_id = aws_vpc.vpc_threatapp.id
}


#Route Tables
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc_threatapp.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw_threatapp.id
    }
}

resource "aws_route_table" "private_route_table" {
    vpc_id = aws_vpc.vpc_threatapp.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gateway_threatapp.id
    }
}



#Route Table Associations
resource "aws_route_table_association" "public_subnet_1_association" {
    subnet_id = aws_subnet.public_subnet_1.id
    route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_2_association" {
    subnet_id = aws_subnet.public_subnet_2.id
    route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_1_association" {
    subnet_id = aws_subnet.private_subnet_1.id
    route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_2_association" {
    subnet_id = aws_subnet.private_subnet_2.id
    route_table_id = aws_route_table.private_route_table.id
}