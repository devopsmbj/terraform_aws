output "subnet_output" {
  value = aws_subnet.my_public_subnet.id
}
output "eip_output" {
  value = aws_eip.elastic.id
}
output "sg_output" {
  value = aws_security_group.my_sg.id
}