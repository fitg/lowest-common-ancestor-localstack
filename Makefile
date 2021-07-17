unit-test:
	poetry run pytest -vv .

lint:
	poetry run flake8

black:
	poetry run black -v .

isort:
	poetry run isort --profile black .

mypy:
	poetry run mypy --strict .

zip:
	zip lambda.zip program.py

startup-localstack:
	docker-compose up -d
	bash wait_for_localstack

terraform:
	sleep 10
	terraform init -input=false
	terraform apply -auto-approve -input=false

test-localstack:
	aws --endpoint-url=http://localhost:4572 s3 ls
	aws --endpoint-url=http://localhost:4574 lambda list-functions

cleanup:
	docker stop localstack-kata_localstack_1
	docker rm localstack-kata_localstack_1
	rm terraform.tfstate
	rm .terraform.lock.hcl
	rm lambda.zip

all: unit-test black isort mypy lint zip startup-localstack terraform test-localstack cleanup
