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

.PHONY: install
install: stop-compose delete-network create-network start-compose ## Build setup (deletes network if exists and re-create)

.PHONY: restart
restart: stop-compose default ## Restart

.PHONY: end
end: stop-compose delete-network ## Stop compose and delete network

.PHONY: create-network
create-network: ## Create network
	@echo "$(YELLOW)==> Create the network$(RESET)"
	@docker network create gitea-network || @echo "$(RED)Can't create docker network, already created ?$(RESET)"

.PHONY: delete-network
delete-network: ## Delete network
	@echo "$(YELLOW)==> Delete previous network if it exists$(RESET)"
	@docker network rm gitea-network || @echo "$(RED)Network does not exist$(RESET)"

.PHONY: start-compose
start-compose: ## Start compose
	@echo "$(YELLOW)==> Starting compose and creating setup$(RESET)"
	@docker-compose -f dev-compose.yml up -d

.PHONY: stop-compose
stop-compose: ## Stop compose
	@echo "$(YELLOW)==> Stopping compose$(RESET)"
	docker-compose -f dev-compose.yml down
