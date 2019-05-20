resource "aws_security_group" "thinkdata" {
  vpc_id = "${aws_vpc.thinkdata.id}"
  name = "thinkdata"
  description = "security group that allows ssh and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  } 
tags {
    Name = "thinkdata"
  }
}
resource "aws_security_group" "thinkdata-db" {
  vpc_id = "${aws_vpc.thinkdata.id}"
  name = "thinkdata-db"
  description = "Allow traffic from public subnet"
  ingress {
      from_port = -1
      to_port = -1
      protocol = "icmp"
      cidr_blocks = ["10.0.1.0/24"]
  }

  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      cidr_blocks = ["10.0.1.0/24"]
  } 
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["10.0.1.0/24"]
  } 
tags {
    Name = "thinkdata-db"
  }
}

