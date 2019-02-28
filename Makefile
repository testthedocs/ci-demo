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

.PHONY: cert
cert: ## Create new selfsigned SSL cert
	@openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout traefik/certs/cert.key -out traefik/certs/cert.crt
	@chmod 644 traefik/certs/cert.crt
	@chmod 600 traefik/certs/cert.key
	@echo "$(YELLOW)Please note: the cert directory is ignored by git (.gitignore)!$(RESET)"

.PHONY: check-cert
check-cert: ## Read SSL cert information from CLI
	@openssl x509 -text -noout -in traefik/certs/cert.crt
	@echo "$(YELLOW)Please note: the cert directory is ignored by git (.gitignore)!$(RESET)"