resource "aws_vpc" "eks_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "eks-vpc"
  }
}

resource "aws_subnet" "eks_vpc_public_subnet" {
  count = 2

  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, var.cidr_bits, count.index)
  availability_zone       = data.aws_availability_zones.availability_zones.names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "eks-vpc-public-subnet"
  }
}

resource "aws_subnet" "eks_vpc_private_subnet" {
  count = 2

  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.cidr_bits, count.index + 2)
  availability_zone = data.aws_availability_zones.availability_zones.names[count.index]

  tags = {
    Name = "eks-vpc-private-subnet"
  }
}

resource "aws_internet_gateway" "eks_vpc_internet_gw" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    "Name" = "eks-vpc-igw"
  }

  depends_on = [aws_vpc.eks_vpc]
}

resource "aws_route_table" "eks_vpc_igw_rt" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_vpc_internet_gw.id
  }

  tags = {
    Name = "eks-vpc-igw-rt"
  }
}

resource "aws_route_table_association" "eks_vpc_subnets_rt_link" {
  count = 2

  subnet_id      = aws_subnet.eks_vpc_public_subnet[count.index].id
  route_table_id = aws_route_table.eks_vpc_igw_rt.id
}

resource "aws_eip" "eks_vpc_nat_gw_eip" {
  vpc = true

  tags = {
    Name = "eks-vpc-nat-gw-eip"
  }
}

resource "aws_nat_gateway" "eks_vpc_nat_gw" {
  allocation_id = aws_eip.eks_vpc_nat_gw_eip.id
  subnet_id     = aws_subnet.eks_vpc_public_subnet[0].id

  tags = {
    Name = "eks-vpc-nat-gw"
  }
}

resource "aws_route" "eks_vpc_nat_route" {
  route_table_id         = aws_vpc.eks_vpc.default_route_table_id
  nat_gateway_id         = aws_nat_gateway.eks_vpc_nat_gw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_security_group" "eks_vpc_public_subnet_sg" {
  vpc_id = aws_vpc.eks_vpc.id

  dynamic "ingress" {
    for_each = [80, 443]
    content {
      description = "description ${ingress.key}"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = {
    Name = "eks-vpc-public-sg"
  }
}

resource "aws_security_group" "eks_vpc_private_subnet_sg" {
  vpc_id = aws_vpc.eks_vpc.id

  ingress {
    description = "with in vpc"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-vpc-private-sg"
  }
}
