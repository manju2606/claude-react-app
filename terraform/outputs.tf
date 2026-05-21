output "cloudfront_url" {
  description = "Public URL of the deployed React app"
  value       = "https://${aws_cloudfront_distribution.website.domain_name}"
}

output "s3_bucket_name" {
  description = "S3 bucket hosting the static files"
  value       = aws_s3_bucket.website.bucket
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID — needed for cache invalidation in CI/CD"
  value       = aws_cloudfront_distribution.website.id
}
