# KubSU Users API

FastAPI приложение с CRUD операциями для управления пользователями.

## Функционал

- Создание пользователя (POST `/users/`)
- Получение списка пользователей (GET `/users/`)
- Получение пользователя по ID (GET `/users/{user_id}`)
- Обновление пользователя (PATCH `/users/{user_id}`)
- Удаление пользователя (DELETE `/users/{user_id}`)

## Запуск приложения

### Локальная разработка

1. Установка зависимостей:
```bash
pip install -e ".[test]"
```

2. Запуск базы данных PostgreSQL:
```bash
docker run -d \
  --name postgres-kubsu \
  -e POSTGRES_USER=kubsu \
  -e POSTGRES_PASSWORD=kubsu \
  -e POSTGRES_DB=kubsu \
  -p 5432:5432 \
  postgres:15
```

3. Запуск приложения:
```bash
uvicorn src.main:app --reload --port 8022
```

### Использование Docker Compose

1. Запуск всех сервисов:
```bash
docker-compose up -d
```

2. Проверка логов:
```bash
docker-compose logs -f app
```

3. Остановка:
```bash
docker-compose down
```

## Тестирование

Запуск тестов:
```bash
pytest tests/ -v
```

## API Endpoints

- `POST /users/` - Создать пользователя
  ```json
  {
    "name": "John Doe"
  }
  ```

- `GET /users/` - Получить список пользователей
  - Query параметры: `skip` (по умолчанию 0), `limit` (по умолчанию 10)

- `GET /users/{user_id}` - Получить пользователя по ID

- `PATCH /users/{user_id}` - Обновить пользователя
  ```json
  {
    "name": "New Name"
  }
  ```

- `DELETE /users/{user_id}` - Удалить пользователя

## CI/CD

При коммите в ветку `master` автоматически:
1. Запускаются тесты
2. Собирается Docker образ
3. Деплой происходит на сервер

## Переменные окружения

- `DATABASE_URL` - URL подключения к PostgreSQL (по умолчанию: `postgresql+psycopg://kubsu:kubsu@127.0.0.1:5432/kubsu`)

## Проверка работы на сервере

После деплоя приложение будет доступно по адресу:
```
http://212.192.134.135:60080/<username>/users/
```

где `<username>` - ваш логин. 
