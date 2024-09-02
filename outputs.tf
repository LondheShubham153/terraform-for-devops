output "arn" {
  value = aws_instance.testinstance.arn
}

output "public_ip" {
  value = aws_instance.testinstance.public_ip
}
