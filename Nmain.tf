resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc-cidr
tags = {
   Name = "vpc${var.NetworkModule}"
  }
}


resource "aws_subnet" "my_public_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.subnet_public_cidr
  #availability_zone = "eu-west-1a"
  tags = {
    Name = "pub_sub_${var.NetworkModule}"
  }
}



resource "aws_internet_gateway" "my_ig" {

   vpc_id = aws_vpc.my_vpc.id
   tags = {
     Name = "Gat_${var.NetworkModule}"
   }
}

resource "aws_network_interface" "ec2_NT" {
  subnet_id = aws_subnet.my_public_subnet.id
  private_ips = var.PrivateIp
  security_groups = [aws_security_group.my_sg.id]
   tags = {
    Name = "NetInt_${var.NetworkModule}"
  }
}


resource "aws_route_table" "my_public_route_table" {
   vpc_id = aws_vpc.my_vpc.id

   route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.my_ig.id
   }

   tags = {
     Name = "Rt_${var.NetworkModule}"
   }
}

resource "aws_route_table_association" "public_1_rt_a" {
 subnet_id = aws_subnet.my_public_subnet.id
 route_table_id = aws_route_table.my_public_route_table
}




#creation dune elastic ip
resource "aws_eip" "elastic" {
  domain   = "vpc"
}


#creation d'un groupe de securite

resource "aws_security_group" "my_sg" {
  name        = "allow_tls"
  description = "Allow tls inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id


  dynamic "ingress" {
    for_each = var.sg_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = [aws_vpc.my_vpc.cidr_block]
    }
  }

  dynamic "egress" {
    for_each = var.sg_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name = "sg_${var.NetworkModule}"
  }

}

resource "aws_ec2_transit_gateway" "trafficTransit" {

  description = "Example Transit Gateway"
  transit_gateway_cidr_blocks = [""]
  }

resource "aws_ec2_transit_gateway_vpc_attachment" "trafficTransitattach" {
     transit_gateway_id = aws_ec2_transit_gateway.trafficTransit.id
     vpc_id = aws_vpc.my_vpc.id
     subnet_ids = [aws_subnet.trafficTransit.id]
     dns_support = true
     ipv6_support = false
     transit_gateway_default_route_table_association = true
     transit_gateway_default_route_table_propagation = true
 }




