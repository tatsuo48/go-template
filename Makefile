.PHONY: up down build-local build logs ps help

up: ## start containers
	docker compose up -d

down: ## stop and remove containers
	docker compose down

build-local: ## create a local image
	docker compose build --no-cache

build: ## create a production image
	docker build -t app:latest --target deploy .

logs: ## show logs
	docker compose logs -f

ps: ## show containers
	docker compose ps

help: ## show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
