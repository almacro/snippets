build:
	@docker build -t almacro/licserver-base base/.
	@docker build -t almacro/licserver-lmgr lmgr/.
	@docker build -t almacro/licserver server/.
	@docker build -t almacro/lictest   client/.
run:
	@docker run --name licserver -h licensing.my.host -d --mac-address="02:cd:c9:43:82:95" --rm -p 27009:27009 -p 27099:27099 almacro/licserver
test:
	@docker run --name lictest --link licserver:licensing.my.host --rm -it almacro/lictest

