# MiniDev
This project demonstrates a workflow that I use when developing simple
microservices locally that will run in Kubernetes.

This workflow uses Minikube as both my local Kubernetes environment, and as the
Docker engine for building my images locally. I chose to use Minikube's Docker
engine so that the container image would be easily available to an
out-of-the-box install of Minikube.

Please note that the artifacts created in this flow are only local to your
machine and Minikube as they are only meant as a means of local test and tune
prior to whatever the next step in your overall development flow is (i.e.,
opening PRs and triggering other build/test suites, etc).

The core of this workflow is the `Makefile`, so to replicate this flow for a
new project, simply copy the `Makefile` into your project, and make some minor
edits (see [Usage](#Usage))

Requires minikube, kubectl, make

## Test Drive
This repo contains a simple flask app to demonstrate the workflow.

Simply clone this repo, and run `make all` from within the project. This will
start up minikube if it's not already running, and use minikube's Docker engine
to build the image so that it's immediately available to minikube for
deployment.

If you like, change a bit of the application code, and run `make all` again.
The application container will be rebuilt and redeployed to your minikube
environment.

## Usage
Copy the Makefile into your project directory. Edit the Makefile to set your
app name, and optionally change the TAG to whatever works for you.

Additionally, you may wish to configure `minikube` to your liking, or modify
the bits that generate the Kubernetes object files to fit your needs.

To build and deploy your app, simply run `make all`.

Run `make help` for more usage information.
