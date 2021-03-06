ROOT_DIR = $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

APP_NAME = Electrum docker make file

SHELL ?= /bin/bash
ARGS = $(filter-out $@,$(MAKECMDGOALS))

BUILD_ID ?= $(shell /bin/date "+%Y%m%d-%H%M%S")

.SILENT: ;               # no need for @
.ONESHELL: ;             # recipes execute in same shell
.NOTPARALLEL: ;          # wait for this target to finish
.EXPORT_ALL_VARIABLES: ; # send all vars to shell
Makefile: ;              # skip prerequisite discovery

# Run make help by default
.DEFAULT_GOAL = help

ifneq ("$(wildcard ./VERSION)","")
VERSION ?= $(shell cat ./VERSION | head -n 1)
else
VERSION ?= 0.0.1
endif

%.env:
	cp $@.dist $@

.PHONY: .title
.title: ## Prints app name and its version
	$(info $(APP_NAME) v$(VERSION))

.PHONY: build
build: ## Builds electrum docker image
	docker build -t electrum-image .

.PHONY: build-and-run
build-and-run: ## Builds electrum docker image
	make build
	make run

.PHONY: run
run: ## Runs electrum docker image
	docker run -v $(PWD)/data:/app/electrum --rm --name electrum-container -p 7777:7777 electrum-image

.PHONY: run-testnet
run-testnet: ## Runs electrum docker image
	docker run --env-file ./.env -v $(PWD)/account_40_port_57854:/app/electrum --rm --name electrum-container -p 7777:7777 electrum-image

.PHONY: run-as-deamon
run-as-deamon: ## Runs electrum docker image
	docker run -d -v $(PWD)/data:/app/electrum --rm --name electrum-container -p 7777:7777 electrum-image

.PHONY: attach
attach: ## attaches to electrum running container
	docker exec -it electrum-container bash

.PHONY: down
down: ## stops electrum running container
	docker stop -t 1 electrum-container

.PHONY: rm
rm: ## removed electrum container
	docker rm electrum-container

.PHONY: rebuild
rebuild: ## full circle of rebuilding container
	make down
	make build
	make run


.PHONY: help
help: ## Show this help and exit (default target)
	echo ''
	printf "                     %s: \033[94m%s\033[0m \033[90m[%s] [%s]\033[0m\n" "Usage" "make" "target" "ENV_VARIABLE=ENV_VALUE ..."
	echo ''
	echo '                     Available targets:'
	# Print all commands, which have '##' comments right of it's name.
	# Commands gives from all Makefiles included in project.
	# Sorted in alphabetical order.
	echo '                     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
	grep -hE '^[a-zA-Z. 0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		 awk 'BEGIN {FS = ":.*?## " }; {printf "\033[36m%+20s\033[0m: %s\n", $$1, $$2}'
	echo '                     ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━'
	echo ''

%:
	@: