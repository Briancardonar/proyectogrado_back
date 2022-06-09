include .env.testing
docker-debug:
	docker-compose -f docker-compose.yml -f docker-compose.debug.yml up -d --build
docker:
	docker-compose -f docker-compose.yml up -d --build
docker-production:
	docker-compose -f docker-compose.production.yml up -d --build
docker-backup:
ifdef file
	docker exec -i sams-db-dev sh -c 'exec mysql -u$(DB_USERNAME) -p$(DB_PASSWORD) $(DB_DATABASE)' < $(file);
else
	echo 'El argumento [file] es requerido.'
endif

docker-migrations:
	docker-compose exec sams php artisan migrate
docker-seeders:
	docker-compose exec sams php artisan db:seed
docker-migrations-seed:
	docker-compose exec sams php artisan migrate --seed

docker-sniff:
	docker-compose exec sams composer sniff
docker-lint:
	docker-compose exec sams composer lint

docker-testing:
	docker-compose --env-file ./.env.testing -f docker-compose.testing.yml up -d --build

docker-runtests:
	bash ./tests.sh

docker-testing-log:
	docker logs --tail 1000 -f sams-back-testing
