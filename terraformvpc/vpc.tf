resource "aws_vpc" "testVPC" {
  cidr_block = "200.0.0.0/16"
  tags {
    Name = "testVPC"
  }
}

resource "aws_internet_gateway" "testIG" {
  vpc_id = "${aws_vpc.testVPC.id}"
  tags {
    Name = "testIG"
  }
}

resource "aws_route_table" "testPubSN-RT" {
  vpc_id = "${aws_vpc.testVPC.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.testIG.id}"
  }
  tags {
    Name = "TestPubSN-RT"
  }
}

resource "aws_subnet" "testPubSN" {
  count = "${length(var.subnet_cidrs_public)}"

  vpc_id = "${aws_vpc.testVPC.id}"
  cidr_block = "${var.subnet_cidrs_public[count.index]}"
  availability_zone = "${var.availability_zones[count.index]}"
}

resource "aws_route_table_association" "testPubSN-RTAssn" {
  count = "${length(var.subnet_cidrs_public)}"

  subnet_id      = "${element(aws_subnet.testPubSN.*.id, count.index)}"
  route_table_id = "${aws_route_table.testPubSN-RT.id}"
}

####################################

