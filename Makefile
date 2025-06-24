.PHONY: build test docker deploy terraform frontend

build:
	mvn clean package -DskipTests

test:
	mvn test

docker:
	docker build -t email-validator .

run:
	docker run -p 8080:8080 email-validator

frontend:
	aws s3 sync src/main/resources/static s3://$(S3_BUCKET_NAME)/ --delete --acl public-read

terraform:
	cd terraform && terraform init && terraform apply -auto-approve

deploy: build frontend terraform
