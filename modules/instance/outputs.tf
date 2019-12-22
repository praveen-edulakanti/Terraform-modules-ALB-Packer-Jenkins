output "PrivateInstanceIds" {
    value = aws_instance.PrivateInstance.*.id
}