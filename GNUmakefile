##make gnostr-test port=<int>
ifneq ($(port),)
PORT                                    :=$(port)
else
PORT                                    :=8080
endif
export PORT

.PHONY:- help
-:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?##/ {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo
more:## 	more help
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/	/'
	#$(MAKE) -f Makefile help

-include Makefile

gnostr-test:## 	gnostr-test
	@$(shell which gnostr-relay) -p $(PORT) || true &
	@echo $(shell which gnostr-relay)
	@echo $(shell which gnostr)
	@echo $(shell which gnostr-weeble)
	@echo $(shell which gnostr-post-event)
	gnostr \
    --sec $(shell gnostr-sha256 $(shell gnostr-weeble)) \
    -t gnostr \
    --tag weeble $(shell gnostr-weeble) \
    --tag wobble $(shell gnostr-wobble) \
    --tag blockheight $(shell gnostr-blockheight) \
    --content "" \
    | gnostr-post-event ws://0.0.0.0:$(PORT)
gnostr-relay-list:## 	gnostr-relay-list
	@echo $(shell which gnostr)
	@echo $(shell which gnostr-weeble)
	@echo $(shell which gnostr-post-event)
	gnostr \
    --sec $(shell gnostr-sha256 $(shell gnostr-weeble)) \
    -t gnostr \
    --tag weeble $(shell gnostr-weeble) \
    --tag wobble $(shell gnostr-wobble) \
    --tag blockheight $(shell gnostr-blockheight) \
    --content "" \
    | gnostr-post-event ws://0.0.0.0:$(PORT)

gnostr-test-proxy:## 	gnsotr-test-proxy
	@echo $(shell which gnostr)
	@echo $(shell which gnostr-weeble)
	@echo $(shell which gnostr-post-event)
	gnostr --sec $(shell gnostr-sha256 $(shell gnostr-weeble)) | gnostr-post-event ws://0.0.0.0:6102

-include cargo.mk
