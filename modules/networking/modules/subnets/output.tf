output "nat_gateway_ids" {
    value = aws_nat_gateway.NATGateway.*.id
}

output "public_subnet_ids" {
    value = aws_subnet.public_subnet.*.id
}

output "private_subnet_ids" {
    value = aws_subnet.private_subnet.*.id
}