variable "bucket_name" {
  type    = string
  description = "The s3 bucket to store your backend. This should be the same bucket name in found in dev/vars.tf"
  default = "YOUR BUCKET NAME HERE"
}