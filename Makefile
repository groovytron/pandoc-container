BUILD_NAME=pandoc-container
COMMON_BUILD_TAGS=--build-arg VCS_REF="$(shell git rev-parse HEAD)" --build-arg BUILD_DATE="$(shell date -u +"%Y-%m-%dT%H:%m:%SZ")"

.PHONY:build
build:
	docker build \
		$(COMMON_BUILD_TAGS) \
		--build-arg PANDOC_VERSION=2.7.2 \
		--build-arg PANDOC_CROSSREF_VERSION=0.3.4.0d \
		--build-arg PANDOC_INCLUDE_CODE_VERSION=1.2.0.2 \
		--tag $(BUILD_NAME):latest \
		.

.PHONY:test
test:
	./test.sh

.PHONY:clean
clean:
	docker images | grep $(BUILD_NAME) | tr -s ' ' | cut -d ' ' -f2 | xargs -I {} echo $(BUILD_NAME):{}
