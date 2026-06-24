.PHONY: init fmt validate lint docs clean

init:
	terraform init -backend=false

fmt:
	terraform fmt -recursive

validate: init
	terraform validate

lint:
	tflint --init
	tflint

docs:
	terraform-docs .

all: fmt validate lint docs

clean:
	rm -rf .terraform .terraform.lock.hcl
