-- FUNCTION geo.latest_wdpa()

DROP FUNCTION IF EXISTS geo.latest_wdpa() CASCADE;

CREATE OR REPLACE FUNCTION geo.latest_wdpa(
	)
    RETURNS SETOF protected_sites.template_wdpa 
    LANGUAGE 'plpgsql'

    COST 100
    IMMUTABLE 
    ROWS 1000
AS $BODY$

BEGIN
RETURN QUERY EXECUTE 'SELECT * FROM protected_sites.'||(
SELECT f_table_name FROM geometry_columns
WHERE f_table_schema='protected_sites' and f_table_name LIKE 'wdpa20%'
ORDER BY f_table_name DESC
LIMIT 1)||';';
END;

$BODY$;

-- MATERIALIZED View geo.wdpa

DROP MATERIALIZED VIEW IF EXISTS geo.wdpa CASCADE;

CREATE MATERIALIZED VIEW geo.wdpa AS SELECT * FROM geo.latest_wdpa() WITH DATA;

CREATE INDEX wdpa_idx ON geo.wdpa USING gist(geom);


