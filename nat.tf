resource "aws_eip" "thinkdata" {
  vpc      = true
}
resource "aws_nat_gateway" "thinkdata-nat-gw" {
  allocation_id = "${aws_eip.thinkdata.id}"
  subnet_id = "${aws_subnet.thinkdata-public-1.id}"
  depends_on = ["aws_internet_gateway.thinkdata-gw"]
}

# VPC setup for NAT
resource "aws_route_table" "thinkdata-private" {
    vpc_id = "${aws_vpc.thinkdata.id}"
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.thinkdata-nat-gw.id}"
    }

    tags {
        Name = "thinkdata-private-1"
    }
}
# route associations private
resource "aws_route_table_association" "thinkdata-private-1-b" {
    subnet_id = "${aws_subnet.thinkdata-private-1.id}"
    route_table_id = "${aws_route_table.thinkdata-private.id}"
}

