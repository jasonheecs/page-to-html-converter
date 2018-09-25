start:
ifdef d
	docker-compose up
else
	docker-compose start
endif

stop:
	docker-compose stop

build:
	cd ./app && bundle install && cd ../
ifdef nd
	docker-compose up --build
else
	docker-compose up --build -d
endif

destroy:
	docker-compose down

update-gem:
	cd ./app && bundle install && cd ../
	docker-compose run web bundle install

open:
	open http://localhost:4567

.PHONY: list
list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs