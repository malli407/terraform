output "vpc_id" {
  value     = aws_vpc.main.id
  sensitive = false
}

output "identity" {
  value = data.aws_caller_identity.current

}