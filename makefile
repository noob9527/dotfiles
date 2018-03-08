all:
	./bin/dotfiles -c ./config/config.yml

docker-build:
	docker build -t dotfiles .

docker-run:
	docker run -it \
		-v $$(pwd)/config:/dotfiles/config:ro \
		dotfiles:latest /bin/bash
