echo "Running post-migrate.sh"
docker ps --filter name=_postgrest_ --format '{{.Names}}'
docker kill -s SIGUSR1 $(docker ps --filter name=_postgrest_ --format '{{.Names}}')