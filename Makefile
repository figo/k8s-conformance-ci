# Makefile

VERSION ?= $(shell git describe --exact-match 2> /dev/null || \
                 git describe --match=$(git rev-parse --short=8 HEAD) --always --dirty --abbrev=8)
REGISTRY ?=luoh

all: build

PWD := $(shell pwd)

provision:
	if [ ! -d "./cross-cloud" ]; then \
		git clone https://github.com/figo/cross-cloud.git; \
	fi
	cd cross-cloud; git checkout feature/vsphere
	docker build ./cross-cloud/ --tag provisioning 

build: provision
	docker build . --tag $(REGISTRY)/k8s-conformance:$(VERSION)
	docker tag $(REGISTRY)/k8s-conformance:$(VERSION) $(REGISTRY)/k8s-conformance:latest
        
upload:
	docker login -u="$(DOCKER_USERNAME)" -p="$(DOCKER_PASSWORD)";
	docker push $(REGISTRY)/k8s-conformance:$(VERSION)
	docker push $(REGISTRY)/k8s-conformance:latest

clean:
	rm -rf cross-cloud
	docker image rm -f provisioning
	docker image rm -f luoh/k8s-conformance:$(VERSION)
	docker image rm -f luoh/k8s-conformance:latest
