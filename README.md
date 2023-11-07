# Overview
This directory has a Spring Boot application that is deployed as an ECS service behind an ALB.

## Pre-requisites
Copy `etc/environment.template` to `etc/environment.sh` and update accordingly.
* `PROFILE`: your AWS CLI profile with the appropriate credentials to deploy
* `ACCOUNTID`: your AWS account id
* `REGION`: your AWS region
* `BUCKET`: your configuration bucket

## Deployment
Deploy the infrastructure resources using `makefile`: `make infrastructure`

After completing the deployment, update the following outputs:
* `O_ECR_REPO`: output repository name

## Testing
To build the application: `make cargo.build` or `make spin.build` (equivalent)  
To run the WASM application locally: `make spin.up`  
To test the API endpoint locally: `make curl.local`

To build the container: `make docker.build`  
To test the container endpoint: `make curl.docker`