#! /bin/sh

echo "Starting cluster"
MASTER_EXTERNAL_PORT=5422 COMPOSE_PROJECT_NAME=citus docker-compose up --scale worker=3 -d

echo "Start psql shell on the master node, create and distribute the database"
docker exec citus_master sh -c "psql -U postgres < /data/setup_tables.sql"

echo "Insert data into the servers"
docker exec citus_master sh -c "psql -U postgres < /data/import_data.sql"
