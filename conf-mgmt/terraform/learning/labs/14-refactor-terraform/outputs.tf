output "public_sg" {
  value = aws_security_group.tf_public_sg.id
}

output  "ingress_port_mapping" {
  value = {
    for ingress in aws_security_group.tf_public_sg.ingress:
      format("From %d", ingress.from_port) => format("To %d", ingress.to_port)
  }
}
