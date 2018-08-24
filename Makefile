# Makefile


all: build

PWD := $(shell pwd)

provision:
	if [ ! -d "./cross-cloud" ]; then \
		git clone https://github.com/figo/cross-cloud.git; \
	fi
	cd cross-cloud; git checkout feature/vsphere
	docker build ./cross-cloud/ --tag provisioning 

build: provision
	docker build . --tag luoh/k8s-conformance:v0.01

upload:
	docker push luoh/k8s-conformance

clean:
	rm -rf cross-cloud
	docker image rm -f provisioning
	docker image rm -f luoh/k8s-conformance:v0.01
