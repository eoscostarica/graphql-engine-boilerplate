FROM hasura/graphql-engine:v1.2.1.cli-migrations-v2

ARG hasura_graphql_migrations_dir
ARG hasura_graphql_metadata_dir
ARG hasura_graphql_database_url

ENV HASURA_GRAPHQL_MIGRATIONS_DIR $hasura_graphql_migrations_dir
ENV HASURA_GRAPHQL_METADATA_DIR $hasura_graphql_metadata_dir
ENV HASURA_GRAPHQL_DATABASE_URL $hasura_graphql_database_url
ENV PORT 8080

EXPOSE $PORT

COPY migrations $HASURA_GRAPHQL_MIGRATIONS_DIR
COPY metadata $HASURA_GRAPHQL_METADATA_DIR

CMD ["graphql-engine", "serve"]
