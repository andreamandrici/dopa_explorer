-- FUNCTION geo.latest_country_atts()

DROP FUNCTION IF EXISTS geo.latest_country_atts() CASCADE;

CREATE OR REPLACE FUNCTION geo.latest_country_atts(
	)
    RETURNS TABLE(english_name text, iso2 text, iso3 text, un_m49 integer, indipendent text, region_code integer, region_name text, subregion_code integer, subregion_name text, intermediate_region_code integer, intermediate_region_name text, least_developed_countries_ldc boolean, land_locked_developing_countries_lldc boolean, small_island_developing_states_sids boolean, developed_developing_countries text, acp boolean, eu_28 boolean, jrc_notes text) 
    LANGUAGE 'plpgsql'

    COST 100
    IMMUTABLE 
    ROWS 1000
AS $BODY$

BEGIN
RETURN QUERY EXECUTE 'SELECT
a.english_name::text,
a.iso2::text,
a.iso3::text,
a.un_m49::integer,
a.indipendent::text,
b.region_code,
b.region_name::text,
b.sub_region_code,
b.sub_region_name::text,
b.intermediate_region_code,
b.intermediate_region_name::text,
CASE
WHEN b.least_developed_countries_ldc IS NOT NULL THEN true
ELSE false
END AS least_developed_countries_ldc,
CASE
WHEN b.land_locked_developing_countries_lldc IS NOT NULL THEN true
ELSE false
END AS land_locked_developing_countries_lldc,
CASE
WHEN b.small_island_developing_states_sids IS NOT NULL THEN true
ELSE false
END AS small_island_developing_states_sids,
b.developed_developing_countries::text,
CASE
WHEN b.acp IS NOT NULL THEN true
ELSE false
END AS acp,
CASE
WHEN b.eu28 IS NOT NULL THEN true
ELSE false
END AS eu28,
b.jrc_notes
FROM  administrative_units.country_codes_iso a
LEFT JOIN administrative_units.unsd_country_grouping b on a.iso3=b.iso_alpha3_code
ORDER BY a.iso3';
END;

$BODY$;

-- MATERIALIZED VIEW geo.country_atts

DROP MATERIALIZED VIEW IF EXISTS geo.country_atts_last CASCADE;

CREATE MATERIALIZED VIEW geo.country_atts_last
AS
 SELECT *
   FROM geo.latest_country_atts()
WITH DATA;
CREATE UNIQUE INDEX country_atts_last_un_m49_idx ON geo.country_atts_last USING btree(un_m49);
COMMENT ON MATERIALIZED VIEW geo.country_atts_last
    IS 'integrates information from:
https://www.iso.org/obp/ui/#search/code/
https://unstats.un.org/unsd/methodology/m49/overview/
http://www.acp.int/content/secretariat-acp (acp field)
http://ec.europa.eu/eurostat/statistics-explained/index.php?title=Glossary:European_Union_(EU) (eu28 field)';

