DOCKER:=$(shell which docker)
export DOCKER
DOCKER_APP_MACOS:=/Applications/Docker.app/Contents/MacOS/Docker
export DOCKER_APP_MACOS
BREW:=$(shell which brew)
export BREW
GO:=$(which go)
export GP
PROJECT_NAME:=plebnet-playground
export PROJECT_NAME
-: build
	@mkdir -p data
build:
	@echo $(DOCKER)
	@echo $(DOCKER_APP_MACOS)
	test  docker && \
		  docker build -t $(PROJECT_NAME)-nostr-rs-relay . || echo
	#test  $(DOCKER_APP_MACOS) && \
	#	  $(DOCKER_APP_MACOS) build -t $(PROJECT_NAME)-nostr-rs-relay .
run:
	@echo $(DOCKER)
	@echo $(DOCKER_APP_MACOS)
	test  docker && docker run -it -p 7000:7000 \
		--mount src=$(PWD)/config.toml,target=/usr/src/app/config.toml,type=bind \
		--mount src=$(PWD)/data,target=/usr/src/app/db,type=bind \
		$(PROJECT_NAME)-nostr-rs-relay || echo
	#test $(DOCKER_APP_MACOS) && $(DOCKER_APP_MACOS) run -it -p 7000:7000 \
	#	--mount src=$(PWD)/config.toml,target=/usr/src/app/config.toml,type=bind \
	#	--mount src=$(PWD)/data,target=/usr/src/app/db,type=bind \
	#	$(PROJECT_NAME)-nostr-rs-relay || echo
noscl:
	#test $(BREW) && $(BREW) install -f golang || sudo apt-get install golang-go || true
	$(GO)install github.com/fiatjaf/noscl@latest
all: - init build run noscl
init:
	@echo $(DOCKER)
	@echo $(DOCKER_APP_MACOS)
	@./scripts/initialize
git-remotes:
	@git remote add gheartsfield	git@git.sr.ht:~gheartsfield/nostr-rs-relay
	@git remote add upstream	git@github.com:scsibug/nostr-rs-relay.git
	@git remote add playground	git@github.com:PLEBNET-PLAYGROUND/playground-nostr-rs-relay.git
nuke-docker:
	@echo $(DOCKER)
	@./scripts/nuke-docker
