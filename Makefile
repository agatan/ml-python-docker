IMAGE_NAME := agatan/ml-python

IMAGE_SUFFIX := latest

.PHONY: build
build:
	docker build --build-arg DISABLE_GPU=1 . -t $(IMAGE_NAME):cpu-$(IMAGE_SUFFIX)
	docker build . -t $(IMAGE_NAME):gpu-$(IMAGE_SUFFIX)

.PHONY: push
push: build
	docker push $(IMAGE_NAME):cpu-$(IMAGE_SUFFIX)
	docker push $(IMAGE_NAME):gpu-$(IMAGE_SUFFIX)
