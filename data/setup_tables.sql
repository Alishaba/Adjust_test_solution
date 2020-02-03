CREATE TABLE installs_by_country(
id INT NOT NULL PRIMARY KEY,
index INT,
country VARCHAR(2),
created_at VARCHAR,
paid BOOLEAN,
installs INT);
SET citus.replication_model = 'streaming';
SELECT create_distributed_table('installs_by_country', 'id');
