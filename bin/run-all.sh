#! /bin/sh

echo "Starting cluster"
MASTER_EXTERNAL_PORT=5422 COMPOSE_PROJECT_NAME=citus docker-compose up --scale worker=3 -d

echo "Start psql shell on the master node, create and distribute the database"
docker exec citus_master psql -U postgres -d postgres -c "CREATE TABLE installs_by_country(\
id INT NOT NULL PRIMARY KEY, \
index INT, \
country VARCHAR(2), \
created_at VARCHAR, \
paid BOOLEAN, \
installs INT);"
docker exec citus_master psql -U postgres -d postgres -c "SET citus.replication_model = 'streaming';"
docker exec citus_master psql -U postgres -d postgres -c "SELECT create_distributed_table('installs_by_country', 'id');"

echo "Insert data into the servers"
docker exec citus_master psql -U postgres -d postgres -c "\copy installs_by_country from 'data/shard1.csv' with csv HEADER;"
docker exec citus_master psql -U postgres -d postgres -c "\copy installs_by_country from 'data/shard2.csv' with csv HEADER;"
docker exec citus_master psql -U postgres -d postgres -c "\copy installs_by_country from 'data/shard3.csv' with csv HEADER;"
