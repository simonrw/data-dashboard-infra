usage:                    ## Show this help
	@grep -Fh "##" $(MAKEFILE_LIST) | grep -Fv fgrep | sed -e 's/:.*##\s*/##/g' | awk -F'##' '{ printf "%-25s %s\n", $$1, $$2 }'

ls-init:  ## Init terraform
	terraform -chdir=init init

ls-plan: ## Plan changes
	terraform -chdir=init plan

ls-apply: ## Plan changes
	terraform -chdir=init apply -auto-approve

ls-reset: ## Clear local terraform state
	rm init/terraform.tfstate*
