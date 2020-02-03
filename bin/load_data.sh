#! /bin/sh

docker exec citus_master psql -U postgres -d postgres -c "SELECT create_distributed_table('installs_by_country', 'id');"
echo "Insert data into the servers"
docker exec citus_master sh -c "psql -U postgres < /data/import_data.sql"