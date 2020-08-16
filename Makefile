# git version to check out and build
DLV_VERSION=v1.5.0

TAG=$(DLV_VERSION)

MIN_IMAGE=oklischat/delve:$(TAG)
SUMO_IMAGE=oklischat/delve-sumo:$(TAG)

build-min:
	docker build --target minimal --build-arg DLV_VERSION --tag $(MIN_IMAGE) .

build-sumo:
	docker build --target sumo --build-arg DLV_VERSION --tag $(SUMO_IMAGE) .

build-all: build-min build-sumo

push-min: build-min
	docker push $(MIN_IMAGE)

push-sumo: build-sumo
	docker push $(SUMO_IMAGE)

push: push-min push-sumo
