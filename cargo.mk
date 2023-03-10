cargo-build:
	@cargo b
cargo-run:
	@cargo r
cargo-install:
	@cargo install --path $(PWD)
	@echo "export PATH=$(CARGO_PATH)/bin:$(PATH)"
cargo-build-release:
	@cargo b --release
cargo-check:
	@cargo c
# vim: set noexpandtab:
# vim: set setfiletype make
