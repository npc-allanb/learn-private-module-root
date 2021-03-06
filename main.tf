provider "aws" {
  region = var.region
}

module "s3-webapp" {
  source  = "app.terraform.io/trigger-training/s3-webapp/aws"
  name        = var.name
  region = var.region
  prefix = var.prefix
  version = "1.0.5"
}

resource "aws_s3_bucket_object" "html_file_upload" {
  bucket = module.s3-webapp.bucket.bucket
  key = "index.html"
  acl = "bucket-owner-full-control"
  source       = "${path.module}/assets/index.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/assets/index.html")
}
