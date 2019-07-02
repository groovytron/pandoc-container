BUILD_NAME=pandoc
COMPOSE_BUILD_NAME=pandoc-container
VERSIONS=2.7.3 2.7.2
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

# .PHONY:test
# test:
# 	./test.sh

.PHONY:clean
clean:
	for VERSION in $(VERSIONS); do \
		docker image rm -f $(COMPOSE_BUILD_NAME):$$VERSION; \
	done
