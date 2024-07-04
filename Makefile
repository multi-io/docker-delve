DLV_VERSION=v1.21.2

TAG=$(DLV_VERSION)-debug1

ARCHS=linux/arm64,linux/amd64

MIN_IMAGE=oklischat/delve:$(TAG)
SUMO_IMAGE=oklischat/delve-sumo:$(TAG)

# build targets also --push because just --load'ing them into Docker isn't directly supported currently -- https://github.com/docker/buildx/issues/59

build-push-min:
	docker buildx build --push --platform $(ARCHS) --target minimal --build-arg DLV_VERSION=$(DLV_VERSION) --tag $(MIN_IMAGE) .

build-push-sumo:
	docker buildx build --push --platform $(ARCHS) --target sumo --build-arg DLV_VERSION=$(DLV_VERSION) --tag $(SUMO_IMAGE) .

build-push-all: build-push-min build-push-sumo
