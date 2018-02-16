all: build

.PHONY: build
build:
	R --slave < build.R

