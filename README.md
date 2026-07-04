## Requirements

- Docker (mandatory)

## Installation

After cloning the repository, it is necessary to create and configure an `.env` file, using the template in `.env.sample`. The project can then be built acording to the stack described in `docker-compose.yml`:

## Credentials

This project uses Rails Encrypted Credentials for database settings.
To edit or view: `EDITOR="nano" bin/rails credentials:edit`
_(Ensure `config/master.key` is present)_.

```bash
docker-compose build
```

### First run and migrations

Migrations and DB operations can be run by directly giving commands with Docker Compose:

```bash
docker-compose run web rails db:create db:migrate
```

Optional: seed the database

```bash
docker-compose run rails db:seed
```

### Launching

By typing `docker-compose up`, the following containers are launched:

- `web`: Rails application
- `db`: PostgreSQL database

The application can be accessed at [localhost:3000](http://localhost:3000)

Once the stack is running, every container can be accessed opening another shell and typing `docker-compose exec web bash`. This can be used to inspect the container or run other operations such as `rails c`; in this respect the console has been preconfigured for pretty printing using `amazing-print`.

## Testing

This application uses RSpec, Factory Bot and json_matchers. Tests can be executed from the shell of a running container with `rails spec` or a dedicated container (and required db) can be launched with `docker-compose run web rails spec`.

## Auth

This project uses JWT to handle api authentication on. JWT is open industry standard (RFC 7519) for representing claims securely between two parties
