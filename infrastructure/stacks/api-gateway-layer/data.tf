data "aws_caller_identity" "current" {}

data "aws_lambda_function" "eligibility_signposting_lambda" {
  function_name = "${terraform.workspace == "default" ? "" : "${terraform.workspace}-"}eligibility_signposting_api"
}

data "aws_acm_certificate" "imported_cert" {
  domain    = "${var.environment}.${local.api_domain_name}"
  types     = ["IMPORTED"]
  provider  = aws.eu-west-2
  key_types = ["RSA_4096"]
}

data "aws_acm_certificate" "validation_cert" {
  domain      = "${var.environment}.${local.api_domain_name}"
  types       = ["AMAZON_ISSUED"]
  provider    = aws.eu-west-2
  key_types   = ["RSA_2048"]
  most_recent = true
}

data "aws_s3_bucket" "truststore_bucket" {
  bucket = "${terraform.workspace == "default" ? "" : "${terraform.workspace}-"}${var.project_name}-${var.environment}-truststore"
}

data "aws_s3_object" "pem_file" {
  bucket = data.aws_s3_bucket.truststore_bucket.bucket
  key    = "truststore.pem"
}


