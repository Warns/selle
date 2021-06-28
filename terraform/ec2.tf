//creating VPC
resource "aws_vpc" "tf-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "tf-vpc"
  }
}
//creating subnet for the vpc
resource "aws_subnet" "subnet-tf" {
  cidr_block = "${cidrsubnet(aws_vpc.tf-vpc.cidr_block, 3, 1)}"
  vpc_id = "${aws_vpc.tf-vpc.id}"
  availability_zone = "us-east-1a"
}
//creating internet gateway and attaching to the vpc
resource "aws_internet_gateway" "tf-gw" {
  vpc_id = "${aws_vpc.tf-vpc.id}"
  tags = {
    Name = "tf-gw"
  }
}
//creating the route table and attaching it to the vpc
resource "aws_route_table" "route-table-tf" {
  vpc_id = "${aws_vpc.tf-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.tf-gw.id}"
  }
  tags = {
    Name = "route-table-tf"
  }
}
//associating the subnet to the route table
resource "aws_route_table_association" "subnet-association" {
  subnet_id      = "${aws_subnet.subnet-tf.id}"
  route_table_id = "${aws_route_table.route-table-tf.id}"
}
//creating security group
resource "aws_security_group" "tf-sg" {
   name = "allow-all-sg"
   vpc_id = "${aws_vpc.tf-vpc.id}"
   ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
   from_port = 22
    to_port = 22
    protocol = "tcp"
  }
// Terraform removes the default rule
   egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }
}
//creating an EC2 instance
resource "aws_instance" "first-tf-ec2" {
  ami = "${var.ami_id}"
  instance_type = "t2.micro"
  key_name = "${var.ami_key_pair_name}"
  security_groups = ["${aws_security_group.tf-sg.id}"]
  tags = {
    Name = "${var.ami_name}"
  }
  subnet_id = "${aws_subnet.subnet-tf.id}"
}
//creating Elastic IP for the instance
resource "aws_eip" "tf-eip" {
  instance = "${aws_instance.first-tf-ec2.id}"
  vpc      = true
}
