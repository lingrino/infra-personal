.PHONY: build clean deploy gomod

build: gomod
	export GO111MODULE=on
	env GOOS=linux go build -ldflags="-s -w" -o bin/notify notify/main.go

clean:
	rm -rf ./bin

deploy: clean build
	sls deploy --verbose

gomod:
	go get -u all
	go mod tidy
