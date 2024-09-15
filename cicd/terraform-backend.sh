#!/bin/bash

BUCKET_NAME="stack-dev-k8s-tf-backend"
REGION="eu-west-2"

echo "Checking if S3 bucket exists..."

if aws s3api head-bucket --bucket "$BUCKET_NAME" 2>/dev/null; then
    echo "Bucket already exists."
else
    echo "Bucket does not exist, creating now..."
    aws s3api create-bucket --bucket "$BUCKET_NAME" --region "$REGION" --create-bucket-configuration LocationConstraint="$REGION"
    echo "Bucket created."
fi
