# Daybreak
A sample project built using NextJS and Django

## Run the project

### Run the containers
```bash
$ cd compose
$ docker compose up -d
```

---

### Run and attach claude-code
```bash
$ cd compose
$ docker compose up -d claude-code && docker compose attach claude-code
```

Login as required


---

### View in browser

NextJS at `localhost:3030`

Django at `localhost:8001`