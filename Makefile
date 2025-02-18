VOLUME_PATH=/home/kali/data
DOCKER=docker
CONTAINER=$(DOCKER) container
COMPOSE_FILE=srcs/docker-compose.yml
COMPOSE=$(DOCKER) compose -f $(COMPOSE_FILE)
VOLUME=$(DOCKER) volume

all: create_dir compose/up

all-d: create_dir compose/up-d

create_dir:
	mkdir -p $(VOLUME_PATH)/db $(VOLUME_PATH)/static

compose/%:
	$(COMPOSE) $(@F) 
.PHONY: compose/% 

compose/up-d:
	$(COMPOSE) up -d
.PHONY: compose/up-d


bash/%:
	$(CONTAINER) exec -it $(@F) bash
.PHONY: bash/%

clean/containers:
	$(CONTAINER) rm -f $$($(CONTAINER) ls -aq)
.PHONY: clean/containers


clean/volumes:
	$(VOLUME) rm -f $$($(VOLUME) ls -q)
.PHONY: clean/volumes

rebuild: compose/build all
rebuild-d: compose/build all

clean: compose/down
	sudo rm -rf $(VOLUME_PATH)/db $(VOLUME_PATH)/static

re: clean
	make all
