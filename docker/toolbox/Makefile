build:
	@docker build -t toolbox/base base/.
	@docker build -t toolbox      main/.
run:
        @docker run -it --rm --name user-toolbox -e USER=ridecell -v $HOME/.ssh:/home/ridecell/.ssh toolbox bash
