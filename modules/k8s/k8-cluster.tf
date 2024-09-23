resource "aws_security_group" "sg-cluster" {
  name = "cluster-sg"
  vpc_id = var.vpc_id
  description = "Networkl security group for the kubernetes cluster"  
  
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
   security_group_id = aws_security_group.sg-cluster.id
   cidr_ipv4 =  var.vpc_cidr
   from_port = 443
   to_port = 443
   ip_protocol = "tcp"

}


resource "aws_vpc_security_group_egress_rule" "egress" {
  security_group_id = aws_security_group.sg-cluster.id
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
  
}


resource "aws_instance" "master" {
    ami = var.ami_type
    instance_type = var.instance_type
    subnet_id = var.public_subnet_id
    security_groups = [aws_security_group.sg-cluster.id]
    tags = {
      Name: "k8-Master"
    }
  
}

resource "aws_instance" "ansible" {
    ami = var.ami_type
    instance_type = var.instance_type
    subnet_id = var.public_subnet_id
    security_groups = [aws_security_group.sg-cluster.id]
    tags = {
      Name: "Ansible-server"
    }
  
}

resource "aws_instance" "nodes" {
  count = var.instance_count
  ami = var.ami_type
  instance_type = var.instance_type
  security_groups = [aws_security_group.sg-cluster.id]
  subnet_id = var.public_subnet_id
  tags = {
    Name = "Node-${count.index + 1}"
  }
}

