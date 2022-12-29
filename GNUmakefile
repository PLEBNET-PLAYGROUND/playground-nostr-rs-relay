DOCKER:=$(shell which docker)
export DOCKER
BREW:=$(shell which brew)
export BREW
GO:=$(which go)
export GP
PROJECT_NAME:=plebnet-playground
export PROJECT_NAME
-: build
	mkdir -p data
build:
	test docker && docker build -t $(PROJECT_NAME)-nostr-rs-relay . || ./scripts/initialize && echo "RERUN: make build"
run:
	test docker && docker run -it -p 7000:7000 \
		--mount src=$(PWD)/config.toml,target=/usr/src/app/config.toml,type=bind \
		--mount src=$(PWD)/data,target=/usr/src/app/db,type=bind \
		$(PROJECT_NAME)-nostr-rs-relay || ./scripts/initialize && echo "RERUN: make run"
noscl:
	$(GO)install github.com/fiatjaf/noscl@latest
all: - init build run noscl
init:
	@./scripts/initialize
	#test $(BREW) && $(BREW) install -f golang || sudo apt-get install golang-go || true
git-remotes:
	@git remote add gheartsfield	git@git.sr.ht:~gheartsfield/nostr-rs-relay
	@git remote add upstream	git@github.com:scsibug/nostr-rs-relay.git
	@git remote add playground	git@github.com:PLEBNET-PLAYGROUND/playground-nostr-rs-relay.git
