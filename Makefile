GCP_PROJECT := prism-hack
APP_NAME := $(shell basename $(shell pwd))
VERSION := $(shell TZ=Asia/Tokyo date +%Y%m%d)

# Initialize
init:
	asdf install
	pushd frontend; yarn install; popd
	go get -v -t -d ./...

format:
	go mod tidy
	go fmt ./...

# Docs
docs.build:
	docker build -t ${APP_NAME}_redoc-cli -f ./docker/Dockerfile.docs .

docs.create:
	docker run --rm -it -v $(shell pwd):/docs ${APP_NAME}_redoc-cli bundle swagger.yaml \
	&& mv ./redoc-static.html docs/index.html

# GCP Login
login:
	gcloud auth login

set.project: login
	gcloud config set project ${GCP_PROJECT}

# GAE Deployment
deploy: frontend.build
	gcloud app deploy --no-promote --quiet --version=${VERSION}

browse:
	gcloud app browse --service=${APP_NAME} --version=${VERSION}

# Docker
docker.build:
	APP_NAME=${APP_NAME} \
	docker-compose build --parallel

docker.up:
	APP_NAME=${APP_NAME} \
	docker-compose up

docker.down:
	docker-compose down

docker.clean: docker.down
	docker rmi --force $(shell docker images -q -f dangling=true)

# Frontend
frontend.upgrade:
	pushd frontend; yarn upgrade; popd

frontend.test:
	cd frontend; yarn test; cd ../

frontend.build:
	cd frontend; yarn install && yarn build && yarn export; cd ../

frontend.serve: frontend.build
	cd frontend; yarn serve; cd ../

# Server
server.test:
	go vet ./...
	${GOPATH}/bin/errcheck ./...
	${GOPATH}/bin/staticcheck ./...
	go test -v --cover ./...
#	go build ./...

server.run:
	go run main.go
