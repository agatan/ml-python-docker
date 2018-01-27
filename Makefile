IMAGE_NAME := agatan/ml-python
DOCKER_FILES := $(shell find dockerfiles -type f)

IMAGE_SUFFIX := latest

.PHONY: build
build: dockerfiles/Dockerfile.cpu dockerfiles/Dockerfile.gpu
	docker build . -f dockerfiles/Dockerfile.cpu -t $(IMAGE_NAME):cpu-$(IMAGE_SUFFIX)
	docker build . -f dockerfiles/Dockerfile.gpu -t $(IMAGE_NAME):gpu-$(IMAGE_SUFFIX)

.PHONY: push
push: build
	docker push $(IMAGE_NAME):cpu-$(IMAGE_SUFFIX)
	docker push $(IMAGE_NAME):gpu-$(IMAGE_SUFFIX)
