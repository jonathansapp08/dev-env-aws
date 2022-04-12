variable "bucket_name" {
  type    = string
  description = "The s3 bucket to store your backend. This should be the same bucket name in found in init/vars.tf"
  default = "my-dev-bucket"
}

variable "host_os" {
  type    = string
  description = "The os your computer is running (linux/windows)"
  default = "linux"
}

variable "ssh_key_name" {
  type    = string
  description = "The name of your ssh key. It is expected to be located at ~/.ssh/"
  default = "vscodekey"
}


variable "ec2_size" {
  type    = string
  description = "The size of your ec2 instance. Learn more about sizes here: https://aws.amazon.com/ec2/instance-types/"
  default = "t3.micro"
}


variable "ip_address" {
  type    = string
  description = "Your IP address. This can be found by googling 'What's my IP'."
  default = "YOUR IP ADDRESS HERE"
}