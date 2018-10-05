-- FUNCTION geo.ecoregions_last()

DROP FUNCTION IF EXISTS geo.latest_ecoregions() CASCADE;

CREATE OR REPLACE FUNCTION geo.latest_ecoregions(
	)
    RETURNS SETOF habitats_and_biotopes.template_ecoregions
    LANGUAGE 'plpgsql'

    COST 100
    IMMUTABLE 
    ROWS 1000
AS $BODY$

BEGIN
RETURN QUERY EXECUTE 'SELECT * FROM habitats_and_biotopes.'||(
SELECT f_table_name FROM geometry_columns
WHERE f_table_schema='habitats_and_biotopes' and f_table_name LIKE 'ecoregions_20%'
ORDER BY f_table_name DESC
LIMIT 1)||';';
END;

$BODY$;


-- MATERIALIZED VIEW geo.ecoregions_last

DROP MATERIALIZED VIEW IF EXISTS geo.ecoregions_last CASCADE;

CREATE MATERIALIZED VIEW geo.ecoregions_last AS
SELECT * FROM geo.latest_ecoregions()
WITH DATA;

CREATE UNIQUE INDEX ecoregions_last_flcode_idx ON geo.ecoregions_last USING btree(first_level_code);
CREATE INDEX ecoregions_last_geom_idx ON geo.ecoregions_last USING gist(geom);
