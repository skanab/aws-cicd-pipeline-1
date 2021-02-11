resource "aws_s3_bucket" "codepipeline-artifacts" {
  bucket = "bmorriso-pipeline-artifacts"
  acl    = "private"
}