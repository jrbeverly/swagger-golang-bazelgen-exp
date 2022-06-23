.DEFAULT_GOAL:=help
SHELL:=/bin/bash

.PHONY: run
run: ## Invoke the executable
	bazel run //cmd/golang-jsonschema -- $(PWD)/cmd/golang-jsonschema/toolchain.yaml $(PWD)/cmd/golang-jsonschema/toolchain.json

.PHONY: build test generate
build: ## Build all targets
	bazel build //...

test: ## Test all targets
	bazel test //...

generate: ## Generate the models
	bazel run //spec:v1alpha
	bazel run //spec:v2alpha
	bazel run //:gazelle
	bazel run //:gazelle-update-repos
	bazel run //:gazelle

.PHONY: help
help: ## Display this help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)