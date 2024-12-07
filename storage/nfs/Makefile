
TERRAFORM = $(shell which terraform)
TERRAFORM_DIR = ./terraform

.PHONY: copy-cloud-init

tf-apply: copy-cloud-init tf-plan
	cd $(TERRAFORM_DIR) ; $(TERRAFORM) apply

tf-plan:
	cd $(TERRAFORM_DIR) ; $(TERRAFORM) plan -out tfplan

cmdline-deploy: copy-cloud-init
	./create-clone.sh

copy-cloud-init:
	scp mu-nfs-cloud-init.yaml root@lab:/var/lib/vz/snippets/mu-nfs-cloud-init.yaml


