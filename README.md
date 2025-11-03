# Daybreak
A sample project built using NextJS and Django

## Run the project:

### Create postgresql password
```bash
$ mkdir -p .envs && echo -e 'POSTGRES_USER="user"\nPOSTGRES_PASSWORD="password"' > .envs/.postgres.env
```

### Create backend envs
```bash
$ mkdir -p .envs && echo -e 'DEBUG=True\nDJANGO_SECRET_KEY="secret"\nDATABASE_HOST="postgres"\nDATABASE_NAME="user"\nDATABASE_USER="user"\nDATABASE_PASSWORD="password"' > .envs/.backend.env
```

### Create frontend envs
```bash
$ mkdir -p .envs && touch .envs/.frontend.env
```

### Run the containers
```bash
$ cd compose
$ docker compose up -d
```

### View in browser

NextJS at `localhost:3030`

Django at `localhost:8001`