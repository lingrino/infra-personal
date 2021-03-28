.PHONY: build clean deploy

build:
	env GOOS=linux go build -ldflags="-s -w" -o bin/ami-cleaner ami-cleaner/main.go

clean:
	rm -rf ./bin

deploy: clean build
	sls deploy --verbose
