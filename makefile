include utils/meta.mk utils/help.mk
LOCAL_DB_URL = postgres://eoscr:password@localhost:5432/eoscr_local

clear-local-db: ##@local Remove the local db container, image and volume
clear-local-db:
	@docker-compose down -v && rm -Rf postgres_data

run-local-db: ##@local Launch your local database postgres server
run-local-db:
	@docker-compose up -d postgres

run: ##@local Run the project locally
run:
	@$(SHELL_EXPORT) docker-compose up -d --build postgres
	@until \
		docker-compose exec postgres pg_isready; \
		do echo waiting for postgres service; \
		sleep 5; done;
	@$(SHELL_EXPORT) docker-compose up --build -d hasura
	@until \
		curl http://localhost:8085/v1/version; \
		do echo waiting for hasura service; \
		sleep 5; done;
	@hasura console --endpoint http://localhost:8085

stop: ##@local Stops the development instance
stop:
	@docker-compose stop

launch-console: ##@local Launch hasura console pointing at local server
launch-console:
	@hasura console --endpoint http://localhost:8085

generate-seed: ##@local Generates a seed dump file with data available on public schema
generate-seed:
	@docker-compose exec \
		postgres pg_dump \
		--schema public \
		--data-only \
		$(LOCAL_DB_URL) \
		| grep -v -E 'search_path'

restore-seed: ##@local Takes a given seed and restores it to the db
restore-seed:
	@docker-compose exec \
		-T \
		postgres psql \
		$(LOCAL_DB_URL)
