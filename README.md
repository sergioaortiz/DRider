# DRider

DRider is a backend application made with Sinatra, Sequel and PostgreSQL.

Matches riders with drivers based on their location, and calculates the total amount to be paid. Finally, it generates an automatic transaction by credit card.

## Getting Started

1. Create an `.env` file in the main path with the following structure:

```ruby
export HOST = localhost
export PORT = 5432
export USER = XXXXXXXXXX
export PASSWORD = XXXXXXXXXX
export DATABASE = drider
export WOMPI_URL = https://sandbox.wompi.co/v1
export PRIVATE_KEY = XXXXXXXXXX
export PUBLIC_KEY = XXXXXXXXXX
export ACCEPTANCE_TOKEN = XXXXXXXXXX
export PAYMENT_SOURCE_ID = XXXXXXXXXX
export REDIRECT_URL = XXXXXXXXXX
export PGADMIN_EMAIL = XXXXXXXXXX   # Email to create an account in the pgAdmin4 image in Docker.
export PGADMIN_PASSWORD = XXXXXXXXXX    # Password to create an account in the pgAdmin4 image in Docker.
```
2. Create a PostgreSQL database named `drider`.
3. In the database, create a user with password and privileges.
4. Install the gems.
```ruby
bundle install
```
5. Run the migrations.
```ruby
sequel -m app/migrations postgres://user:password@localhost:5432/drider
```
6. Run server.
```ruby
rackup
```

## Endpoints

### Start ride

This endpoint associates the rider with the closest driver, according to the `initial latitude and longitude`. Then it creates a ride in the database and returns its id.

```http
PUT http://localhost:9292/v1/rides/start-ride
```
### Authentication

Use the following Bearer Token.
```ruby
Q#JGbAtn!U5h3BLQbEQ2&qWVfI203mTv
```

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `legal_id` | `string` | **Required**. Rider identification number |
| `legal_id_type` | `string` | **Required**. Rider ID type |
| `starting_latitude` | `string` | **Required**. Rider starting latitude |
| `starting_longitude` | `string` | **Required**. Rider starting longitude |

The following existing values in the database can be used for the `legal_id` attribute: `1026589764`, `1026597874`, `1287984567`, `1098784545` and `1056987584`.

### Response

```css
{
  "data" : {
    "id_ride" : string
  }
}
```
The `id_ride` attribute must be sent in the body of the `end-ride` Endpoint.

### Status Codes

`start-ride` returns the following status codes:

| Status Code | Description |
| :--- | :--- |
| 200 | `OK` |
| 422 | `INPUT VALIDATION ERROR` |
| 404 | `NOT FOUND` |
| 500 | `INTERNAL SERVER ERROR` |

### End ride

This endpoint calculates the total amount to be paid for the trip, according to the distance and the time elapsed. At the end, it executes the API of the transaction service and registers the movement in the database.

```http
PUT http://localhost:9292/v1/rides/end-ride
```
### Authentication

Use the following Bearer Token.
```ruby
Q#JGbAtn!U5h3BLQbEQ2&qWVfI203mTv
```

| Parameter | Type | Description |
| :--- | :--- | :--- |
| `id_ride` | `string` | **Required**. Ride ID |
| `installments` | `string` | **Required**. Number of installments |
| `final_latitude` | `string` | **Required**. End latitude of ride |
| `final_longitude` | `string` | **Required**. End longitude of ride |

The value of the `id_ride` attribute comes from the return value of the `start-ride` endpoint.

### Response

```css
{
    "data": {
        "id": string,
        "created_at": string,
        "finalized_at": string,
        "amount_in_cents": number,
        "reference": string,
        "customer_email": string,
        "currency": string,
        "payment_method_type": string,
        "payment_method": {
            "type": string,
            "extra": {
                "bin": string,
                "name": string,
                "brand": string,
                "exp_year": string,
                "exp_month": string,
                "last_four": string,
                "card_holder": string
            },
            "installments": number
        },
        "status": string,
        "status_message": string,
        "billing_data": string,
        "shipping_address": string,
        "redirect_url": string,
        "payment_source_id": number,
        "payment_link_id": string,
        "customer_data": {
            "legal_id": string,
            "full_name": string,
            "phone_number": string,
            "legal_id_type": string
        },
        "bill_id": string,
        "taxes": []
    },
    "meta": {}
}
```

### Status Codes

`end-ride` returns the following status codes:

| Status Code | Description |
| :--- | :--- |
| 200 | `OK` |
| 422 | `INPUT VALIDATION ERROR` |
| 404 | `NOT FOUND` |
| 500 | `INTERNAL SERVER ERROR` |

## Testing

Run to do tests.

```ruby
rspec
```

## Docker

1. Create a `Dockerfile` in the main project path with the following structure:

```ruby
FROM ruby:3.2.1
WORKDIR /drider
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
CMD sequel -m app/migrations postgres://user:password@postgres:5432/drider  # Same user and password declared in the '.env' file
EXPOSE 9292
CMD ["rackup"]
```

2. Create the Docker container.

```css
docker-compose build
docker-compose up
```

3. Access pgAdmin4 web at **localhost:8001** with the credentials declared in `PGADMIN_EMAIL` and `PGADMIN_EMAIL`.
4. In the database, create a user with password and privileges.
