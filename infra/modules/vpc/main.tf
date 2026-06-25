#VPC
resource "aws_vpc" "vpc-threatapp" {
    cidr_block = var.vpc-cidrblock  
}

#IGW
resource "aws_internet_gateway" "igw-threatapp" {
    vpc_id = aws_vpc.vpc-threatapp.id
}

#Subnets
resource "aws_subnet" "public-subnet-1" {
    vpc_id = aws_vpc.vpc-threatapp.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "eu-west-2a"
}

resource "aws_subnet" "public-subnet-2" {
    vpc_id = aws_vpc.vpc-threatapp.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = true
    availability_zone = "eu-west-2b"
}

resource "aws_subnet" "private-subnet-1" {
    vpc_id = aws_vpc.vpc-threatapp.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "eu-west-2a"
}

resource "aws_subnet" "private-subnet-2" {
    vpc_id = aws_vpc.vpc-threatapp.id
    cidr_block = "10.0.4.0/24"
    availability_zone = "eu-west-2b"
}


#NAT Gateway
resource "aws_eip" "nat-eip" {
    domain = "vpc"
}

resource "aws_nat_gateway" "nat-gateway-threatapp" {
    allocation_id = aws_eip.nat-eip.id
    subnet_id = aws_subnet.public-subnet-1.id
}


#Route Tables
resource "aws_route_table" "public-route-table" {
    vpc_id = aws_vpc.vpc-threatapp.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw-threatapp.id
    }
}

resource "aws_route_table" "private-route-table" {
    vpc_id = aws_vpc.vpc-threatapp.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-gateway-threatapp.id
    }
}



#Route Table Associations
resource "aws_route_table_association" "public-subnet-1-association" {
    subnet_id = aws_subnet.public-subnet-1.id
    route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-subnet-2-association" {
    subnet_id = aws_subnet.public-subnet-2.id
    route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private-subnet-1-association" {
    subnet_id = aws_subnet.private-subnet-1.id
    route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "private-subnet-2-association" {
    subnet_id = aws_subnet.private-subnet-2.id
    route_table_id = aws_route_table.private-route-table.id
}