output "used_ami" {
  value = data.aws_ami.ubuntu.id
}

output "instance_ip" {
  value = aws_instance.tt_instance.public_ip
}