# Input bucket for parquet data
resource "aws_s3_bucket" "input-parquet-data" {
  bucket = "${var.project}-${var.environment}-parquet-data"

}

resource "aws_s3_bucket_versioning" "input-parquet-data-versioning" {
  bucket = aws_s3_bucket.input-parquet-data.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "input-parquet-data-acl" {
  bucket = aws_s3_bucket.input-parquet-data.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "input-parquet-data-encryption" {
  bucket = aws_s3_bucket.input-parquet-data.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Bucket for SQS input queue large messages (1 day retention)
resource "aws_s3_bucket" "input-sqs-bucket" {
  bucket = "${var.project}-${var.environment}-tf-input-queue-bucket"

}

resource "aws_s3_bucket_lifecycle_configuration" "input-sqs-bucket-lifecycle" {
  bucket = aws_s3_bucket.input-sqs-bucket.id

  rule {
    id = "DeleteAfterOneDay"
    expiration {
      days = 1
    }
    status = "Enabled"
    filter {}
  }
}

resource "aws_s3_bucket_public_access_block" "input-sqs-bucket-acl" {
  bucket = aws_s3_bucket.input-sqs-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "input-sqs-bucket-encryption" {
  bucket = aws_s3_bucket.input-sqs-bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Bucket for SQS output queue large messages (1 day retention)
resource "aws_s3_bucket" "output-sqs-bucket" {
  bucket = "${var.project}-${var.environment}-tf-output-queue-bucket"

}

resource "aws_s3_bucket_lifecycle_configuration" "output-sqs-bucket-lifecycle" {
  bucket = aws_s3_bucket.output-sqs-bucket.id

  rule {
    id = "DeleteAfterOneDay"
    expiration {
      days = 1
    }
    status = "Enabled"
    filter {}
  }

}

resource "aws_s3_bucket_public_access_block" "output-sqs-bucket-acl" {
  bucket = aws_s3_bucket.output-sqs-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "output-sqs-bucket-encryption" {
  bucket = aws_s3_bucket.output-sqs-bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Dead letter queue bucket for SQS
resource "aws_s3_bucket" "dead-letter-sqs-bucket" {
  bucket = "${var.project}-${var.environment}-tf-dead-letter-queue-bucket"

}

resource "aws_s3_bucket_lifecycle_configuration" "dead-letter-sqs-bucket-lifecycle" {
  bucket = aws_s3_bucket.dead-letter-sqs-bucket.id

  rule {
    id = "DeleteAfterSevenDays"
    expiration {
      days = 7
    }
    status = "Enabled"
    filter {}
  }
}

resource "aws_s3_bucket_public_access_block" "dead-letter-sqs-bucket-acl" {
  bucket = aws_s3_bucket.dead-letter-sqs-bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dead-letter-sqs-bucket-encryption" {
  bucket = aws_s3_bucket.dead-letter-sqs-bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}