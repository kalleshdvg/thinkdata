# Internet VPC
resource "aws_vpc" "thinkdata" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags {
        Name = "thinkdata"
    }
}


# Subnets
resource "aws_subnet" "thinkdata-public-1" {
    vpc_id = "${aws_vpc.thinkdata.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-south-1a"

    tags {
        Name = "thinkdata-public-1"
    }

}
resource "aws_subnet" "thinkdata-private-1" {
    vpc_id = "${aws_vpc.thinkdata.id}"
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "ap-south-1b"

    tags {
        Name = "thinkdata-private-1"
    }
}


# Internet GW
resource "aws_internet_gateway" "thinkdata-gw" {
    vpc_id = "${aws_vpc.thinkdata.id}"

    tags {
        Name = "thinkdata"
    }
}

# route tables
resource "aws_route_table" "thinkdata-public" {
    vpc_id = "${aws_vpc.thinkdata.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.thinkdata-gw.id}"
    }

    tags {
        Name = "thinkdata-public-1"
    }
}

# route associations public
resource "aws_route_table_association" "thinkdata-public-1-a" {
    subnet_id = "${aws_subnet.thinkdata-public-1.id}"
    route_table_id = "${aws_route_table.thinkdata-public.id}"
}


