#!/bin/bash
if [ ! -e .env ]; then
    cp .env.example .env
fi

docker-compose up -d --build

docker-compose exec app composer install

docker-compose exec app php artisan migrate --seed