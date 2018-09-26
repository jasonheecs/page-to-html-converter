.PHONY: list
.SILENT: open

start:
	docker-compose start
	@sleep 1
	@make open

stop:
	docker-compose stop

build:
	cd ./app && bundle install && cd ../
	docker-compose up --build -d

destroy:
	docker-compose down

update-gem:
	cd ./app && bundle install && cd ../
	docker-compose exec web /bin/bash -c "bundle install"

open:
	open http://localhost:4567

list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs