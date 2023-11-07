cargo.build:
	cargo build --target wasm32-wasi --release

spin.build:
	spin build
spin.up:
	spin up

curl:
	curl -s http://127.0.0.1:3000/ | jq
