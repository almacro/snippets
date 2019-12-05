provider "aws" {
  region = "${var.aws_region}"
}

resource "random_id" "tf_bucket_id" {
  count       = "${var.number_of_instances}"
  byte_length = 2
}

resource "aws_s3_bucket" "tf_code" {
  count         = "${var.number_of_instances}"
  bucket        = "${var.project_name}-${random_id.tf_bucket_id.*.dec[count.index]}"
  
  acl           = "private"
  force_destroy =  true

  tags {
    name = "tf_bucket${count.index+1}"
  }
}