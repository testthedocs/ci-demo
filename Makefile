# The shell we use
SHELL := /bin/bash

# We like colors
# From: https://coderwall.com/p/izxssa/colored-makefile-for-golang-projects
RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`
YELLOW=`tput setaf 3`

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
.PHONY: help
help: ## This help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: logs
logs: ## Show logs
	@echo "$(YELLOW)==> Logs$(RESET)"
	@docker-compose -f docker-compose.yml logs -f

.PHONY: ps
ps: ## Report processes
	@docker-compose -f docker-compose.yml ps

.PHONY: compose-up
compose-up: ## Start docker-compose
	@echo "$(YELLOW)==> Starting compose and creating setup$(RESET)"
	@docker-compose -f docker-compose.yml up -d

.PHONY: compose-down
compose-down: ## Stop docker-compose
	@echo "$(YELLOW)==> Stopping compose$(RESET)"
	docker-compose -f docker-compose.yml down

.PHONY: create-network
create-network: ## Create network
	@echo "$(YELLOW)==> Create the network$(RESET)"
	@docker network create ci-network || @echo "$(RED)Can't create docker network, already created ?$(RESET)"

.PHONY: delete-network
delete-network: ## Delete network
	@echo "$(YELLOW)==> Delete previous network if it exists$(RESET)"
	@docker network rm ci-network || @echo "$(RED)Network does not exist$(RESET)"

.PHONY: cert
cert: ## Create SSL cert with mkkcert

.PHONY: check-cert
check-cert: ## Read SSL cert information from CLI
	#@openssl x509 -text -noout -in traefik/certs/cert.crt ##needs fixing
	@echo "$(YELLOW)Please note: the cert directory is ignored by git (.gitignore)!$(RESET)"