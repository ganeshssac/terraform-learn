output "nginxinstance" {
    value = aws_instance.nginxEC2.public_ip

}

output "rds" {
    value = aws_db_instance.mariadb.endpoint
    
}
output "ELB" {
  value = aws_elb.my-elb.dns_name
}
