run:
	docker-compose up -d db && docker-compose run --service-ports web bash

sh:
	docker-compose run web bash
