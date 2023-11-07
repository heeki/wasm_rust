include etc/environment.sh

# rust
cargo.build:
	cargo build --target wasm32-wasi --release

# local spin
spin.build:
	spin build
spin.up:
	spin up

# local testing
curl.local:
	curl -s http://127.0.0.1:3000/ | jq
curl.docker:
	curl -s http://127.0.0.1:3001/ | jq

# pre-requisite infrastructure
infrastructure: infrastructure.package infrastructure.deploy
infrastructure.package:
	sam package --profile ${PROFILE} -t ${INFRASTRUCTURE_TEMPLATE} --output-template-file ${INFRASTRUCTURE_OUTPUT} --s3-bucket ${BUCKET} --s3-prefix ${INFRASTRUCTURE_STACK}
infrastructure.deploy:
	sam deploy --profile ${PROFILE} -t ${INFRASTRUCTURE_OUTPUT} --stack-name ${INFRASTRUCTURE_STACK} --parameter-overrides ${INFRASTRUCTURE_PARAMS} --capabilities CAPABILITY_NAMED_IAM

# docker
docker.build:
	docker buildx build --platform wasi/wasm --provenance=false -t ${C_TAG} .
docker.run:
	docker run -d --platform=wasi/wasm --runtime=io.containerd.spin.v1 -p 3001:80 ${C_TAG}

docker: docker.build docker.login docker.tag docker.push
docker.login:
	aws ecr --profile ${PROFILE} get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${C_REPO_BASE}
docker.tag:
	docker tag ${C_TAG} ${C_REPO_URI}
docker.push:
	docker push ${C_REPO_URI}
