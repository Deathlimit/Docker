.PHONY: help build test dev stop clean

IMAGE_NAME = kubsu/python-crud

help: ## Показать справку
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "%-15s %s\n", $$1, $$2}'

build: ## Собрать образ
	docker build -t $(IMAGE_NAME) .

test: ## Запустить тесты локально
	docker-compose up -d db
	@sleep 5
	docker run --rm --network host \
		-e DATABASE_URL="postgresql+psycopg://kubsu:kubsu@localhost:5432/kubsu" \
		$(IMAGE_NAME) python -m pytest -v tests/
	docker-compose down

dev: ## Запустить для разработки
	docker-compose up --build

stop: ## Остановить сервисы
	docker-compose down

clean: ## Очистить ресурсы
	docker-compose down -v
	docker system prune -f 
