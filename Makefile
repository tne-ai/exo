SHELL := /usr/bin/env bash

## install: installation with uv, asdf and direnv with swap for install to setup.py
# pyproject.toml does not handle dependency chekcing for mlx, and other gpu
# things
.PHONY: install
install:
	[[ -r pyproject.toml ]] && mv pyproject.toml pyproject.toml.bak
	uv pip install -e .
	[[ -r pyproject.toml.bak ]] && mv pyproject.toml.bak pyproject.toml

## naked: pip install to system python into naked environment
.PHONY: naked
naked:
	pip install -e .

## venv: create a venv and install there
.PHONY: venv
venv:
	install.sh

## exo: run exo in background
.PHONY: exo
exo:
	uv run exo

## tailscale: run exo using trailscale discovery set environment TAILSCALE_API_KEY and TAILSCALE_TAILNET
.PHONY: tailscale
tailscale:
	uv run exo --discovery-module tailscale

## thunderbay: run with Thunderbay disks
.PHONY: thunderbay
thunderbay:
	EXO_HOME="/Volumes/Thunderbay 8/Exo" uv run exo --discovery-module tailscale

## hagabis: run with Hagabis disks
.PHONY: hagabis
hagabis:
	EXO_HOME="/Volumes/Hagabis/Exo" uv run exo --discovery-module tailscale

.DEFAULT_GOAL := help
.PHONY: help

# https://swcarpentry.github.io/make-novice/08-self-doc/ is simpler just need
## help: available commands (the default)
help: $(MAKEFILE_LIST)
	@sed -n 's/^##//p' $(MAKEFILE_LIST)
