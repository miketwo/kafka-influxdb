.PHONY: all up stop down clean help

# e.g. make up RUNTIME (py2, py3 or pypy)
RUNTIME=py2

all: clean up

up:
	docker-compose -f docker/common-services.yml -f docker/${RUNTIME}/docker-compose.yml build
	docker-compose -f docker/common-services.yml -f docker/${RUNTIME}/docker-compose.yml up -d --force-recreate

stop:
	docker-compose -f docker/common-services.yml -f docker/${RUNTIME}/docker-compose.yml stop

down:
	docker-compose -f docker/common-services.yml -f docker/${RUNTIME}/docker-compose.yml down

logs:
	docker-compose -f docker/common-services.yml -f docker/${RUNTIME}/docker-compose.yml logs

stats:
	docker-compose -f docker/common-services.yml -f docker/${RUNTIME}/docker-compose.yml logs kafkainfluxdb

messages:
	docker-compose -f docker/common-services.yml up kafkacat

clean:
	docker-compose -f docker/common-services.yml -f docker/${RUNTIME}/docker-compose.yml kill
	docker-compose -f docker/common-services.yml -f docker/${RUNTIME}/docker-compose.yml rm -f

help:
	@echo "Command                     Description"
	@echo "make                        docker-compose up"
	@echo "make up                     docker-compose up"
	@echo "make stop                   docker-compose stop"
	@echo "make down                   docker-compose down"
	@echo "make logs                   docker-compose logs"
	@echo "make stats                  docker-compose logs kafkainfluxdb"
	@echo "make messages               Create sample messages for benchmark"
	@echo "make clean                  docker-compose clean && docker-compose rm -f"
	@echo "make <cmd> RUNTIME=<env>    Choose runtime environment (py2, py3, pypy or logstash). Default: py2"
