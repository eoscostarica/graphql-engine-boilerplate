# Hasura boilerplate

#### ENV and CONFIG files

You need to add .env and config.yaml. Please not use for production the provided examples.

## Setup

It is tested on macOS

```bash
make run
```

#### Clearing the database to get a fresh one

In case you want to start fresh, you can clear your local database and create a brand
new one by running:

```bash
$ make clear-local-db run
```

**IMPORTANT NOTE**: If you happen to create/modify seed data, please make sure you run:

```bash
$ make generate-seed
```

And make sure the data is correct, and if so, you then may run:

```bash
$ make generate-seed > db/seeds.sql
```

Once all of that is done, you can restore seed-data by running:

```bash
$ cat db/seeds.sql | make restore-seed
```
