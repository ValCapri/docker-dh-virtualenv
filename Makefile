DISTRIBUTION ?= $(shell git rev-parse --abbrev-ref HEAD)
REPOSITORY   ?= sebdoido/docker-dh-virtualenv
VERSION      ?= 0.11
BUILD_ID     ?= $(shell date +%Y%m%d)
IMAGE        ?= $(REPOSITORY):$(DISTRIBUTION)-$(VERSION)-$(BUILD_ID)

BUILD_OPTIONS  = -t $(IMAGE)
BUILD_OPTIONS += --build-arg application_version=$(VERSION)
ifdef http_proxy
BUILD_OPTIONS += --build-arg http_proxy=$(http_proxy)
endif
ifdef https_proxy
BUILD_OPTIONS += --build-arg https_proxy=$(https_proxy)
endif

default: lint build

build:
	docker build $(BUILD_OPTIONS) .
	docker tag $(IMAGE) $(REPOSITORY):$(VERSION)-$(DISTRIBUTION)-latest

lint:
	 docker run -it --rm -v "$(PWD)/Dockerfile:/Dockerfile:ro" redcoolbeans/dockerlint

push:
	docker push $(REPOSITORY):$(VERSION)-$(DISTRIBUTION)-latest

.PHONY: build lint push
