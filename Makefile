.PHONY: docker-build docker-push

IMAGE_NAME = groovenauts/magellan-rails-example
DOCKER_VERSION = $(shell cat DOCKER_VERSION)

UNAME = $(shell uname)
ifeq "$(UNAME)" "Darwin"
SUDO =
else
SUDO = sudo
endif


docker-build:
	$(SUDO) docker build -t $(IMAGE_NAME):$(DOCKER_VERSION) .

docker-push:
	$(SUDO) docker push $(IMAGE_NAME):$(DOCKER_VERSION)


