start:
	docker-compose start

stop:
	docker-compose stop

build:
ifdef nd
	docker-compose up --build
else
	docker-compose up --build -d
endif

destroy:
	docker-compose down

update-gem:
	docker-compose run web bundle install

open:
	open http://localhost:4567