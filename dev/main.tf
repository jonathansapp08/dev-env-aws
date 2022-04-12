resource "aws_vpc" "vscode_dev_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vscode dev"
  }
}

resource "aws_subnet" "vscode_dev_subnet" {
  vpc_id                  = aws_vpc.vscode_dev_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "vscode dev-public"
  }
}

resource "aws_internet_gateway" "vscode_dev_internet_gateway" {
  vpc_id = aws_vpc.vscode_dev_vpc.id

  tags = {
    Name = "vscode dev-igw"
  }
}

resource "aws_route_table" "vscode_dev_route_table" {
  vpc_id = aws_vpc.vscode_dev_vpc.id

  tags = {
    Name = "vscode dev-public-rt"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.vscode_dev_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vscode_dev_internet_gateway.id
}

resource "aws_route_table_association" "vscode_dev_route_table_association" {
  subnet_id      = aws_subnet.vscode_dev_subnet.id
  route_table_id = aws_route_table.vscode_dev_route_table.id
}

resource "aws_security_group" "vscode_dev_sg" {
  name        = "vscode_dev_sg"
  description = "vscode dev security group"
  vpc_id      = aws_vpc.vscode_dev_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${ip_address}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "vscode_auth" {
  key_name   = "vscodekey"
  public_key = file("~/.ssh/${ssh_key_name}.pub")
}

resource "aws_instance" "dev_node" {
  instance_type          = "${ec2_size}"
  ami                    = data.aws_ami.server_ami.id
  key_name               = aws_key_pair.vscode_auth.id
  vpc_security_group_ids = [aws_security_group.vscode_dev_sg.id]
  subnet_id              = aws_subnet.vscode_dev_subnet.id
  user_data              = file("./scripts/userdata.tpl")

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "dev-node"
  }

  provisioner "local-exec" {
    command = templatefile("./scripts/${var.host_os}-ssh-config.tpl", {
      hostname     = self.public_ip,
      user         = "ubuntu",
      identityfile = "~/.ssh/${ssh_key_name}"
    })

    interpreter = var.host_os == "linux" ? ["bash", "-c"] : ["Powershell", "-Command"]
  }
}
