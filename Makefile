SHELL := /usr/bin/env bash

## install: pip install to system python
.PHONY: install
install:
	pip install -e .

## venv: create a venv and install there
.PHONY: venv
venv:
	install.sh

## run: run exo in background
.PHONY: run
run:
	exo

## uv: installation with uv, asdf and direnv
.PHONY: uv
uv:
	uv pip install -e .
	uv run exo

.DEFAULT_GOAL := help
.PHONY: help

# https://swcarpentry.github.io/make-novice/08-self-doc/ is simpler just need
## help: available commands (the default)
help: $(MAKEFILE_LIST)
	@sed -n 's/^##//p' $(MAKEFILE_LIST)
