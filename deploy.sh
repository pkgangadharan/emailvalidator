#!/bin/bash

set -e

echo "Building Java app..."
mvn clean package -DskipTests

echo "Uploading frontend to S3..."
aws s3 sync src/main/resources/static s3://$S3_BUCKET_NAME/ --delete --acl public-read

echo "Deploying infrastructure with Terraform..."
cd terraform
terraform init
terraform apply -auto-approve
