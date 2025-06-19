CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

ALTER SYSTEM SET shared_preload_libraries = 'pg_stat_statements';
ALTER SYSTEM SET log_statement = 'all';
ALTER SYSTEM SET log_duration = on;
ALTER SYSTEM SET log_min_duration_statement = 100;

SELECT pg_reload_conf();

DO $$
BEGIN
    RAISE NOTICE 'Database initialized successfully for KubSU application';
END $$; 
