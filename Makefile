# git version to check out and build
DLV_VERSION=v1.5.0
IMAGE=oklischat/delve:$(DLV_VERSION)

build:
	docker build --build-arg DLV_VERSION --tag $(IMAGE) .

push: build
	docker push $(IMAGE)
