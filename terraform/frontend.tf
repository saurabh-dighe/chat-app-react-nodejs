
resource "aws_instance" "React_app"{
  ami                         = ami-0d947e680ad5f6093
  instance_type               = t3.micro
  subnet_id                   = aws_subnet.public-subnet
  vpc_security_group_ids      = aws_security_group.allow_tls
  iam_instance_profile        = "EC2-Admin"
} 

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["10.0.2.0/24"]
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

