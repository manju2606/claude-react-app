variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Globally unique S3 bucket name for hosting the React app"
  type        = string
}

variable "project_name" {
  description = "Project name used for resource tagging"
  type        = string
  default     = "my-react-app"
}
