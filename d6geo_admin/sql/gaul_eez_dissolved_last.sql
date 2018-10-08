-- FUNCTION geo.latest_gaul_eez_dissolved()

DROP FUNCTION IF EXISTS geo.latest_gaul_eez_dissolved() CASCADE;

CREATE OR REPLACE FUNCTION geo.latest_gaul_eez_dissolved(
	)
    RETURNS SETOF administrative_units.template_gaul_eez_dissolved 
    LANGUAGE 'plpgsql'

    COST 100
    IMMUTABLE 
    ROWS 1000
AS $BODY$

BEGIN
RETURN QUERY EXECUTE 'SELECT * FROM administrative_units.'||(
SELECT f_table_name FROM geometry_columns
WHERE f_table_schema='administrative_units' and f_table_name LIKE 'gaul_eez_dissolved_20%'
ORDER BY f_table_name DESC
LIMIT 1)||';';
END;

$BODY$;

-- MATERIALIZED VIEW: geo.gaul_eez_last_dissolved

DROP MATERIALIZED VIEW IF EXISTS geo.gaul_eez_dissolved_last CASCADE;

CREATE MATERIALIZED VIEW geo.gaul_eez_dissolved_last AS
SELECT * FROM geo.latest_gaul_eez_dissolved() WITH DATA;
CREATE UNIQUE INDEX gaul_eez_dissolved_last_cid_idx ON geo.gaul_eez_dissolved_last USING btree(country_id);
CREATE INDEX gaul_eez_dissolved_last_geom_idx ON geo.gaul_eez_dissolved_last USING gist(geom);
