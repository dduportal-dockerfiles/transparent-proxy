.PHONY: build test deploy all

export DOCKER_IMAGE_NAME ?= dduportal/transparent-proxy
export DOCKER_IMAGE_TAG ?= $(shell git rev-parse --short HEAD)

CURRENT_GIT_BRANCH ?= $(shell git rev-parse --abbrev-ref HEAD)

all: build test

build:
	docker build \
		--tag $(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_TAG) \
		./

test:
	bats $(CURDIR)/tests/

deploy:
	curl -v -H "Content-Type: application/json" \
		--data '{"source_type": "Branch", "source_name": "$(CURRENT_GIT_BRANCH)"}' \
		-X POST https://registry.hub.docker.com/u/dduportal/transparent-proxy/trigger/$(DOCKER_HUB_TOKEN)/
