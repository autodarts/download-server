VERSION=0.1.1

build:
	go build -o .bin/main -ldflags="-X 'main.Version=${VERSION}'" main.go

build-linux:
	GOOS=linux GOARCH=amd64 go build -o .bin/main-linux -ldflags="-X 'main.Version=${VERSION}'" main.go

run:
	go run main.go

docker-build:
	docker buildx build -t ghcr.io/autodarts/download-server:${VERSION} --load --platform=linux/amd64 .

docker-run:
	docker run --rm --name ghcr.io/autodarts/download-server:${VERSION} -p 5180:5180 autodarts/download-server

docker-push:
	cat ~/github-token.txt | docker login https://ghcr.io -u tnolle --password-stdin
	docker push ghcr.io/autodarts/download-server:${VERSION}

deploy:
	VERSION=${VERSION} envsubst < deployment.yaml | kubectl apply -n autodarts -f -

publish:
	make build-linux
	make docker-build
	make docker-push
	make deploy