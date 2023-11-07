FROM scratch as temp
COPY spin.toml /spin.toml
COPY target/wasm32-wasi/release/wasm_rust.wasm target/wasm32-wasi/release/wasm_rust.wasm

FROM scratch
COPY --from=temp . .
ENTRYPOINT ["/spin.toml"]