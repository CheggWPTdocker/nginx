NAME = cheggwpt/nginx
VERSION = 0.0.8

.PHONY: all build test tag_latest release ssh

all: build tag_latest

build:
	docker build -t $(NAME):$(VERSION) .

tag_latest:
	docker tag $(NAME):$(VERSION) $(NAME):latest

test:
	docker build -t nginx_test .
	docker run -d -p 127.0.0.1:8080:80 --name nginx_test nginx_test
	curl -vsf -H 'Accept-Encoding: gzip' 'http://127.0.0.1:8080/' &> /dev/stdout
	curl -vsf 'http://127.0.0.1:8080/' &> /dev/stdout
	docker kill nginx_test
	docker rm nginx_test
	docker rmi nginx_test

release: tag_latest
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"
