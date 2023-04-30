act-rs-relay:## 	run act -vr -W .github/workflows/rs-relay.yml
	@pushd $(PWD) && export $(cat ~/GH_TOKEN.txt) && act -vr -W .github/workflows/rs-relay.yml && popd
