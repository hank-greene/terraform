output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "gw_id" {
    value = aws_internet_gateway.gw.id
}

output "rt" {
    value = aws_route_table.rt.id
}
