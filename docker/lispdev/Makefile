build:
	@docker build -t lispdev/base    base/.
	@docker build -t lispdev/clozure clozure/.
	@docker build -t lispdev/slime	 slime/.
	@docker build -t lispdev         main/.
run:
	@docker run -it --rm --name lispdev lispdev bash
clean-images:
	@docker rmi -f $(docker images -q --filter="reference='lispdev*'")
