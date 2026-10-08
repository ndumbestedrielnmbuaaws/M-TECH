#!/usr/bin/env bash
# Deploy the M TECH INC website to an AWS S3 static website bucket.
# Usage: ./deploy/deploy-aws-s3.sh <bucket-name> [region]
# Needs: AWS CLI v2 configured (aws configure) with S3 permissions.
set -euo pipefail

BUCKET="${1:?Give a bucket name, e.g. mtech-inc-website}"
REGION="${2:-eu-south-1}"   # Milan; change if you prefer another Region

cd "$(dirname "$0")/.."

if ! aws s3api head-bucket --bucket "$BUCKET" 2>/dev/null; then
  echo "Creating bucket $BUCKET in $REGION..."
  if [ "$REGION" = "us-east-1" ]; then
    aws s3api create-bucket --bucket "$BUCKET"
  else
    aws s3api create-bucket --bucket "$BUCKET" --region "$REGION" \
      --create-bucket-configuration LocationConstraint="$REGION"
  fi
fi

echo "Allowing public read for the website..."
aws s3api put-public-access-block --bucket "$BUCKET" --public-access-block-configuration \
  BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false
aws s3api put-bucket-policy --bucket "$BUCKET" --policy "{
  \"Version\": \"2012-10-17\",
  \"Statement\": [{
    \"Sid\": \"PublicReadWebsite\",
    \"Effect\": \"Allow\",
    \"Principal\": \"*\",
    \"Action\": \"s3:GetObject\",
    \"Resource\": \"arn:aws:s3:::$BUCKET/*\"
  }]
}"

aws s3 website "s3://$BUCKET/" --index-document index.html --error-document index.html

echo "Uploading site..."
aws s3 cp index.html "s3://$BUCKET/index.html" \
  --content-type "text/html; charset=utf-8" --cache-control "max-age=300"

echo
echo "Done. Your site is live at:"
echo "  http://$BUCKET.s3-website.$REGION.amazonaws.com"
echo "For HTTPS and your own domain, put CloudFront in front of the bucket (see README)."
