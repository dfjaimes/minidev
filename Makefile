# This Makefile is intended for use when deving locally with Minikube

APP := "simpleservice"
TAG := "local-$$(date +%s)"

.DEFAULT_GOAL := help

## all
##	- build and deploy application to Minikube
.PHONY: all
all: miniclean minibuild minideploy

## minikube-start
##	- start minikube if not running
.PHONY: minikube-start
minikube-start:
	@minikube status || \
			minikube start \
			--vm-driver=virtualbox \
			--bootstrapper kubeadm \
			--memory=4096

## minicontext
##	- set kubernetes config to minikube
.PHONY: minicontext
minicontext: minikube-start
	@kubectl config use-context minikube

## minibuild
##	- build app using Minikube's Docker engine
.PHONY: minibuild
minibuild: Dockerfile minikube-start
	@eval $$(minikube docker-env); \
			docker build --pull -t $(APP):$(TAG) -t $(APP):latest .
	@eval $$(minikube docker-env -u)

## minideploy
##	- deploy app to Minikube
.PHONY: minideploy
minideploy: k8s/deployment.yaml minicontext
	@kubectl apply -f $<

## miniclean
##	- clean up all the things
.PHONY: miniclean
miniclean: minicontext
	-@kubectl delete deployment $(APP)
	@rm -rf k8s/
	@eval $$(minikube docker-env); \
			docker image prune -af; \
			docker container prune -f
	@eval $$(minikube docker-env -u)

## k8s/deployment.yaml
##	- create kubernetes deployment YAML
k8s/deployment.yaml: minibuild
	@mkdir -p $(@D)
	@kubectl run $(APP) \
			--image=$(APP):latest \
			--image-pull-policy=IfNotPresent \
			--labels="app=$(APP)" \
			--dry-run=true \
			-o yaml > $@

## minikube-stop
##	- shutdown minikube
.PHONY: minikube-stop
minikube-stop:
	@minikube status && \
			minikube stop

## cleanup
##	- your mom doesn't code here, clean up after yourself
cleanup: miniclean minikube-stop

## help
##	- what you're reading right now
.PHONY: help
help: Makefile
	@sed -n 's/^##//p' $<
