IMAGE=oklischat/delve:1.10.3

build:
	docker build --tag $(IMAGE) .

push: build
	docker push $(IMAGE)
