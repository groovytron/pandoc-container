BUILD_NAME=pandoc
OWNER=groovytron
COMPOSE_BUILD_NAME=pandoc-container
VERSIONS=2.9 2.8 2.7
LATEST=3.8
LATEST_LABEL=latest
ALL=$(addprefix pandoc,$(VERSIONS))
VCS_REF="$(shell git rev-parse HEAD)"
BUILD_DATE="$(shell date -u +"%Y-%m-%dT%H:%m:%SZ")"

.PHONY: all
all: $(ALL)

.PHONY: $(ALL)
$(ALL):
	BUILD_DATE=$(BUILD_DATE) \
	BUILD_NAME=$(BUILD_NAME) \
	COMPOSE_BUILD_NAME=$(COMPOSE_BUILD_NAME) \
	VCS_REF=$(VCS_REF) \
	docker-compose -f build.yaml build \
		$@

.PHONY:tag
tag:
	for VERSION in $(VERSIONS); do \
		docker tag $(COMPOSE_BUILD_NAME):$$VERSION $(OWNER)/$(BUILD_NAME):$$VERSION; \
	done && \
	docker tag $(COMPOSE_BUILD_NAME):$(LATEST) $(OWNER)/$(BUILD_NAME):$(LATEST_LABEL)

.PHONY:publish
publish: tag
	for VERSION in $(VERSIONS); do \
		docker push $(OWNER)/$(BUILD_NAME):$$VERSION; \
	done && \
	docker push $(OWNER)/$(BUILD_NAME):$(LATEST_LABEL)

.PHONY:clean
clean:
	for VERSION in $(VERSIONS); do \
		docker image rm -f $(COMPOSE_BUILD_NAME):$$VERSION; \
	done
