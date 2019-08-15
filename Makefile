SHELL                 := /bin/bash

TEST_FLAGS            ?=

export TEST_FLAGS

test:
	parallel $(PARALLEL_FLAGS) \
		"$(MAKE) test-{}" ::: \
			lib \
			adapter

benchmark-lib:
	go test -v -benchtime=500ms -bench=. ./lib/...

benchmark-adapter:
	go test -v -benchtime=500ms -bench=. ./adapter/...

benchmark: benchmark-lib benchmark-adapter

test-lib:
	go test -v ./lib/...

test-adapter:
	go test -v ./adapter/...

goimports:
	for FILE in $$(find -name "*.go" | grep -v vendor); do \
		goimports -w $$FILE; \
	done
