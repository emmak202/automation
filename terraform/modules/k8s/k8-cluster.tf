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
   tags = {
     Name = "Allow SSH form All Network"
   }
   

}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
   security_group_id = aws_security_group.sg-cluster.id
   cidr_ipv4 =  "0.0.0.0/0"
   from_port = 80
   to_port = 80
   ip_protocol = "tcp"
   tags = {
     Name = "Allow http"
   }
   

}

resource "aws_vpc_security_group_ingress_rule" "allow_http2" {
   security_group_id = aws_security_group.sg-cluster.id
   cidr_ipv4 =  "0.0.0.0/0"
   from_port = 8080
   to_port = 8080
   ip_protocol = "tcp"
   tags = {
     Name = "Allow http 8080"
   }
   

}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
   security_group_id = aws_security_group.sg-cluster.id
   cidr_ipv4 =  "0.0.0.0/0"
   from_port = 443
   to_port = 443
   ip_protocol = "tcp"
   tags = {
     Name = "Allow https"
   }
   

}

resource "aws_vpc_security_group_ingress_rule" "Kube_api_server" {
   security_group_id = aws_security_group.sg-cluster.id
   cidr_ipv4 =  "0.0.0.0/0"
   from_port = 6443
   to_port = 6443
   ip_protocol = "tcp"
   tags = {
     Name = "Allow api server"
   }
   

}

resource "aws_vpc_security_group_ingress_rule" "allow_etcd" {
   security_group_id = aws_security_group.sg-cluster.id
   cidr_ipv4 =  "0.0.0.0/0"
   from_port = 2379
   to_port = 2380
   ip_protocol = "tcp"
   tags = {
     Name = "Allow etcd"
   }
   

}

resource "aws_vpc_security_group_ingress_rule" "allow_kublet_api" {
   security_group_id = aws_security_group.sg-cluster.id
   cidr_ipv4 =  "0.0.0.0/0"
   from_port = 10250
   to_port = 10250
   ip_protocol = "tcp"
   tags = {
     Name = "Allow kube api"
   }
   

}

resource "aws_vpc_security_group_ingress_rule" "allow_kube-scheduler" {
   security_group_id = aws_security_group.sg-cluster.id
   cidr_ipv4 =  "0.0.0.0/0"
   from_port = 10259
   to_port = 10259
   ip_protocol = "tcp"
   tags = {
     Name = "Allow kube scheduler"
   }
   

}

resource "aws_vpc_security_group_ingress_rule" "allow_kube-ctl_manager" {
   security_group_id = aws_security_group.sg-cluster.id
   cidr_ipv4 =  "0.0.0.0/0"
   from_port = 10257
   to_port = 10257
   ip_protocol = "tcp"
   tags = {
     Name = "Allow kubectl manager"
   }
   

}

resource "aws_vpc_security_group_ingress_rule" "allow_load_balancer" {
   security_group_id = aws_security_group.sg-cluster.id
   cidr_ipv4 =  "0.0.0.0/0"
   from_port = 10256
   to_port = 10256
   ip_protocol = "tcp"
   tags = {
     Name = "Allow load balancer"
   }
   

}


resource "aws_vpc_security_group_ingress_rule" "allow_node_ports" {
   security_group_id = aws_security_group.sg-cluster.id
   cidr_ipv4 =  "0.0.0.0/0"
   from_port = 30000
   to_port = 32767
   ip_protocol = "tcp"
   tags = {
     Name = "Allow Node ports"
   }
   

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

