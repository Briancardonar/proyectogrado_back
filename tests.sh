docker-compose -f docker-compose.testing.yml exec sams-testing composer install
docker-compose -f docker-compose.testing.yml exec sams-testing php artisan db:wipe --env=testing
docker-compose -f docker-compose.testing.yml exec sams-testing php artisan migrate --env=testing
docker-compose -f docker-compose.testing.yml exec sams-testing php artisan passport:install --env=testing
docker-compose -f docker-compose.testing.yml exec sams-testing php artisan key:generate --env=testing
docker-compose -f docker-compose.testing.yml exec sams-testing php artisan cache:clear --env=testing
docker-compose -f docker-compose.testing.yml exec sams-testing php artisan config:clear --env=testing
docker-compose -f docker-compose.testing.yml exec sams-testing php artisan route:clear --env=testing
docker-compose -f docker-compose.testing.yml exec sams-testing php artisan optimize:clear --env=testing
docker-compose -f docker-compose.testing.yml exec sams-testing php artisan test --testsuite feature
