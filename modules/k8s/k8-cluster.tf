resource "aws_security_group" "sg-cluster" {
  name = "cluster-sg"
  vpc_id = var.vpc_id
  description = "Networkl security group for the kubernetes cluster" 
  tags = {
    Name = "Cluster-NSG"
  }
  
}


resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
   security_group_id = aws_security_group.sg-cluster.id
   cidr_ipv4 =  "0.0.0.0/0"
   from_port = 22
   to_port = 22
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

