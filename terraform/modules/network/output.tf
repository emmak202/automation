output "vpc-id" {
    value = aws_vpc.main.id
  
}

output "public1_id" {
  value = aws_subnet.public1.id
}