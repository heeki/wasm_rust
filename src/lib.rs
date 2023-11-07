use anyhow::Result;
use spin_sdk::{
    http::{Request, Response},
    http_component,
};
use serde::{Deserialize, Serialize};

#[derive(Debug, Deserialize, Serialize)]
struct Message {
    body: String
}

/// A simple Spin HTTP component.
#[http_component]
fn handle_wasm_rust(req: Request) -> Result<Response> {
    println!("{:?}", req.headers());
    let message = Message { body: "hello world!".to_string() };
    let output = serde_json::to_string(&message).unwrap();
    Ok(http::Response::builder()
        .status(200)
        .header("foo", "bar")
        .body(Some(output.into()))?)
}
