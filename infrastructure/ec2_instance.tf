resource "aws_security_group" "tt_instance_ssh_sg" {
  name        = "Allow SSH traffic"
  description = "Allow SSH traffic"

  ingress {
    description = "SSH worldwide"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ssh policy"
  }
}

resource "aws_security_group" "tt_egress_sg" {
  name        = "Allow outside traffic"
  description = "Allow outside traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name   = "egress policy"
    Source = "Tech Task"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu-minimal/images/hvm-ssd/ubuntu-focal-20.04-amd64-minimal-*"]
  }

  owners = ["099720109477"]
}

resource "aws_key_pair" "tt_instance_credentials" {
  key_name   = "login"
  public_key = "${file(var.pubkey_location)}"

  tags = {
    Name   = "Tech task instance login key"
    Source = "Tech Task"
  }
}

resource "aws_instance" "tt_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.tt_instance_credentials.id
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.tt_instance_profile.name

  vpc_security_group_ids = [
    aws_security_group.tt_instance_ssh_sg.id,
    aws_security_group.tt_egress_sg.id
  ]

  root_block_device {
    volume_size = 8
  }

  tags = {
    Name   = "Tech task instance"
    Source = "Tech Task"
  }

  # Install ping and docker
  user_data = "${file("install_docker.sh")}"
}