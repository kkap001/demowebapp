resource "aws_security_group" "ec2_sg" {
  name        = "${var.project}-${var.env}-ec2-sg"
  description = "Security group for EC2 instance"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ssh_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.ssh_cidr_block
    }
  }

  dynamic "ingress" {
    for_each = var.web_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.web_cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project}-${var.env}-sg"
    Project = var.project
    Env     = var.env
  }
}

resource "aws_instance" "ec2" {
  count                       = var.length
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  associate_public_ip_address = var.eip
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  root_block_device {
    volume_size           = var.volume_size
    volume_type           = var.volume_type
    encrypted             = var.encrypted
    delete_on_termination = var.delete_on_termination
  }

  iam_instance_profile = var.iam_role

  tags = {
    Name    = "${var.project}-${var.env}-ec2-${count.index}"
    Project = var.project
    Env     = var.env
  }
}
