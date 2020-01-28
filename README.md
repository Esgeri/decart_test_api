# README

## Тестовая задание от компании Decart

Необходимо реализовать сервис со следующим функционалом на Ruby on Rails.
В базе данных (желательно применить Postgresql) должна быть таблица currency c колонками:
id — первичный ключ
name — название валюты
rate — курс валюты к рублю
И соответсвующая модель.
Должна быть Rake таска для обновления данных в таблице currency. Данные по курсам валют можно взять отсюда: http://www.cbr.ru/scripts/XML_daily.asp
Реализовать 2 REST API метода:
GET /currencies — должен возвращать список курсов валют с возможность пагинации
GET /currencies/:id — должен возвращать курс валюты для переданного id
Ответ должен быть в формате JSON.
Наличие тестов обязательно.
API должно быть закрыто bearer авторизацией.

## Приступая к работе

Проверьте версии

$ ruby -v  # ruby 2.3.1
$ rails -v # rails 5.2.4

### Установка

##### Склонируйте репозиторий
```
$ git clone git@github.com:Esgeri/decart_test_api.git
```

##### Установите гемы
```
$ bundle install
```

##### Конфигурация базы данных
```
# PostgreSQL. Versions 9.1 and up are supported.

default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: user_name
  password: <%= ENV['DECART_TEST_API_DATABASE_PASSWORD'] %>

development:
  <<: *default
  host: ''
  database: decart_test_api_development

test:
  <<: *default
  database: decart_test_api_test

production:
  <<: *default
  database: decart_test_api_production
  username: user_name
  password: <%= ENV['DECART_TEST_API_DATABASE_PASSWORD'] %>

```

##### Создание базы данных
```
rails db:create
```

##### Создание миграции
```
$ rake db:migrate
```

### Запуск rake задач

```
$ rake currency:save_exchange_rates    # Сохранить курсы валют
```

```
$ rake currency:update_exchange_rates  # Обновить курсы валют
```

#### API Endpoints

POST /signup         Регистрация
POST /auth/login     Войти
GET /currencies      Список валют
GET /currencies/:id  Вернеть валюту

##### Запросы к API
Используйте httpie в качестве HTTP-клиента

##### Запрос на регистрацию пользователя
```
$ http :3000/signup name=john email=john@mail.com password=foobar password_confirmation=foobar
```

##### Ответ
```
HTTP/1.1 201 Created
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"4219d1f00516dcf7728081a724b467ce"
Transfer-Encoding: chunked
X-Request-Id: 16fdfac9-22d5-447b-a3e6-773a9ada928c
X-Runtime: 0.334009

{
    "auth_token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1ODAzMzM5MzJ9.AYhVE9gbip6vJ_IUkztrIVnIGT9A3j7XQaNoAatKhak", 
    "message": "Account created successfully"
}
```

##### Запрос токена
```
$ http :3000/auth/login email=john@mail.com password=foobar
```

##### Ответ
```
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"45f939da18a77467a785af63220d00cc"
Transfer-Encoding: chunked
X-Request-Id: 9d1ccaa2-8d1b-4d36-9765-4213289ce459
X-Runtime: 0.211398

{
    "auth_token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1ODAzMzQwMjN9.IxjMMKu0SOza1k3gUe_FhR9gklIDC-9c1VJAym9Y25s"
}
```

##### Запрос всех валют
```
$ http GET :3000/currencies Authorization:"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1ODAzMzQwMjN9.IxjMMKu0SOza1k3gUe_FhR9gklIDC-9c1VJAym9Y25s"
```

##### Ответ
```
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"25f27f33f84de9ccad6e77a9c313a63e"
Transfer-Encoding: chunked
X-Request-Id: 8ce87118-5286-4de6-8e87-36502ceb103d
X-Runtime: 0.011600

{
    "data": [
        {
            "attributes": {
                "created-at": "2020-01-28T21:31:20.164Z", 
                "name": "Австралийский доллар", 
                "rate": "42.0", 
                "updated-at": "2020-01-28T21:31:20.164Z"
            }, 
            "id": "1", 
            "type": "currencies"
        }, 
        {
            "attributes": {
                "created-at": "2020-01-28T21:31:20.177Z", 
                "name": "Азербайджанский манат", 
                "rate": "37.0", 
                "updated-at": "2020-01-28T21:31:20.177Z"
            }, 
            "id": "2", 
            "type": "currencies"
        }, 
        {
            "attributes": {
                "created-at": "2020-01-28T21:31:20.188Z", 
                "name": "Фунт стерлингов Соединенного королевства", 
                "rate": "81.0", 
                "updated-at": "2020-01-28T21:31:20.188Z"
            }, 
            "id": "3", 
            "type": "currencies"
        }, 
        {
            "attributes": {
                "created-at": "2020-01-28T21:31:20.199Z", 
                "name": "Армянских драмов", 
                "rate": "13.0", 
                "updated-at": "2020-01-28T21:31:20.199Z"
            }, 
            "id": "4", 
            "type": "currencies"
        }, 
        {
            "attributes": {
                "created-at": "2020-01-28T21:31:20.210Z", 
                "name": "Белорусский рубль", 
                "rate": "29.0", 
                "updated-at": "2020-01-28T21:31:20.210Z"
            }, 
            "id": "5", 
            "type": "currencies"
        }
    ], 
    "links": {
        "first": "http://localhost:3000/currencies?page%5Bnumber%5D=1&page%5Bsize%5D=5", 
        "last": "http://localhost:3000/currencies?page%5Bnumber%5D=7&page%5Bsize%5D=5", 
        "next": "http://localhost:3000/currencies?page%5Bnumber%5D=2&page%5Bsize%5D=5", 
        "prev": null, 
        "self": "http://localhost:3000/currencies?page%5Bnumber%5D=1&page%5Bsize%5D=5"
    }
}
```

##### Запрос страницы (пагинация)
```
$ http GET :3000/currencies page=3 Authorization:"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1ODAzMzQwMjN9.IxjMMKu0SOza1k3gUe_FhR9gklIDC-9c1VJAym9Y25s"
```

##### Ответ
```
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"1215332d47c44ba03fa50a65018cbfb4"
Transfer-Encoding: chunked
X-Request-Id: 1f518cbd-ef3b-45a7-9b74-79f27e066ca4
X-Runtime: 0.012014

{
    "data": [
        {
            "attributes": {
                "created-at": "2020-01-28T21:31:20.279Z", 
                "name": "Доллар США", 
                "rate": "62.0", 
                "updated-at": "2020-01-28T21:31:20.279Z"
            }, 
            "id": "11", 
            "type": "currencies"
        }, 
        {
            "attributes": {
                "created-at": "2020-01-28T21:31:20.289Z", 
                "name": "Евро", 
                "rate": "69.0", 
                "updated-at": "2020-01-28T21:31:20.289Z"
            }, 
            "id": "12", 
            "type": "currencies"
        }, 
        {
            "attributes": {
                "created-at": "2020-01-28T21:31:20.302Z", 
                "name": "Индийских рупий", 
                "rate": "88.0", 
                "updated-at": "2020-01-28T21:31:20.302Z"
            }, 
            "id": "13", 
            "type": "currencies"
        }, 
        {
            "attributes": {
                "created-at": "2020-01-28T21:31:20.312Z", 
                "name": "Казахстанских тенге", 
                "rate": "16.0", 
                "updated-at": "2020-01-28T21:31:20.312Z"
            }, 
            "id": "14", 
            "type": "currencies"
        }, 
        {
            "attributes": {
                "created-at": "2020-01-28T21:31:20.322Z", 
                "name": "Канадский доллар", 
                "rate": "47.0", 
                "updated-at": "2020-01-28T21:31:20.322Z"
            }, 
            "id": "15", 
            "type": "currencies"
        }
    ], 
    "links": {
        "first": "http://localhost:3000/currencies?page%5Bnumber%5D=1&page%5Bsize%5D=5", 
        "last": "http://localhost:3000/currencies?page%5Bnumber%5D=7&page%5Bsize%5D=5", 
        "next": "http://localhost:3000/currencies?page%5Bnumber%5D=4&page%5Bsize%5D=5", 
        "prev": "http://localhost:3000/currencies?page%5Bnumber%5D=2&page%5Bsize%5D=5", 
        "self": "http://localhost:3000/currencies?page%5Bnumber%5D=3&page%5Bsize%5D=5"
    }
}
```

##### Запрос одной валюты
```
$ http GET :3000/currencies/1 Authorization:"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1ODAzMzQwMjN9.IxjMMKu0SOza1k3gUe_FhR9gklIDC-9c1VJAym9Y25s"
```

##### Ответ
```
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"773460d9920e6b71497a32e4a62858eb"
Transfer-Encoding: chunked
X-Request-Id: ff405cda-2b45-4dbf-88dd-33e37b1539d2
X-Runtime: 0.006377

{
    "data": {
        "attributes": {
            "created-at": "2020-01-28T21:31:20.164Z", 
            "name": "Австралийский доллар", 
            "rate": "42.0", 
            "updated-at": "2020-01-28T21:31:20.164Z"
        }, 
        "id": "1", 
        "type": "currencies"
    }
}
```

##### Запрос без авторизации невозможно
```
$ http GET :3000/currencies
```

##### Ответ
```
HTTP/1.1 422 Unprocessable Entity
Cache-Control: no-cache
Content-Type: application/json; charset=utf-8
Transfer-Encoding: chunked
X-Request-Id: 6e2f10df-3050-4f6c-9c35-c72cbfabd2d9
X-Runtime: 0.002782

{
    "message": "Missing token"
}
```

### Тестирование
```
bundle exec rspec spec -fd
```

##
__Note:__ Rails API

### Author

* **Mirbek Askerov's** - [Resume](https://esgeri.github.io/cv)

