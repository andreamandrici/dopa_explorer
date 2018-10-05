-- DROP FOREIGN TABLES

DROP FOREIGN TABLE IF EXISTS geo.country_atts_last CASCADE;
DROP FOREIGN TABLE IF EXISTS geo.gaul_eez_last CASCADE;
DROP FOREIGN TABLE IF EXISTS geo.gaul_eez_dissolved_last CASCADE;
DROP FOREIGN TABLE IF EXISTS geo.wdpa_last CASCADE;
DROP FOREIGN TABLE IF EXISTS geo.ecoregions_last CASCADE;

-- IMPORT FOREIGN TABLES

IMPORT FOREIGN SCHEMA geo
LIMIT TO (
country_atts_last,
gaul_eez_last,
gaul_eez_dissolved_last,
wdpa_last,
ecoregions_last
) FROM SERVER d6geo INTO geo;

-- ADD DESCRIPTIONS TO FOREIGN TABLES

COMMENT ON FOREIGN TABLE geo.country_atts_last IS 'provides (updated from d6geo, read only by admin) attributes (iso codes,regions, country groupings, acp, eu28) to GAUL-EEZ||';
COMMENT ON FOREIGN TABLE geo.gaul_eez_last IS 'provides (updated from d6geo, read only by admin) GAUL-EEZ geometries|GEOGRAPHIC|';
COMMENT ON FOREIGN TABLE geo.gaul_eez_dissolved_last IS 'provides (updated from d6geo, read only by admin) GAUL-EEZ geometries dissolved; used for analysis|GEOGRAPHIC|';
COMMENT ON FOREIGN TABLE geo.wdpa_last IS 'provides (updated from d6geo, read only by admin) WDPA geometries|GEOGRAPHIC|';
COMMENT ON FOREIGN TABLE geo.ecoregions_last IS 'provides (updated from d6geo, read only by admin) ecoregions geometries|GEOGRAPHIC|';

-- CREATE MATERIALIZED VIEWS

-- geo.mv_country_atts
DROP MATERIALIZED VIEW IF EXISTS geo.mv_country_atts CASCADE;
CREATE MATERIALIZED VIEW geo.mv_country_atts AS SELECT * FROM geo.country_atts_last;
COMMENT ON MATERIALIZED VIEW geo.mv_country_atts IS 'provides (read only by all) last attributes (iso codes,regions, country groupings, acp, eu28) to GAUL-EEZ||';
CREATE UNIQUE INDEX mv_country_atts_un_m49_idx ON geo.mv_country_atts USING btree(un_m49);
GRANT ALL ON TABLE geo.mv_country_atts TO h05mandand;
GRANT ALL ON TABLE geo.mv_country_atts TO h05ibex;
GRANT SELECT ON TABLE geo.mv_country_atts TO h05ibexro;

-- geo.mv_gaul_eez
DROP MATERIALIZED VIEW IF EXISTS geo.mv_gaul_eez CASCADE;
CREATE MATERIALIZED VIEW geo.mv_gaul_eez AS SELECT * FROM geo.gaul_eez_last;
COMMENT ON MATERIALIZED VIEW geo.mv_gaul_eez IS 'provides (read only by all) last GAUL-EEZ geometries|GEOGRAPHIC|';
CREATE UNIQUE INDEX mv_gaul_eez_iobj_idx ON geo.mv_gaul_eez USING btree(id_object);
CREATE INDEX mv_gaul_eez_geom_idx ON geo.mv_gaul_eez USING gist(geom);
GRANT ALL ON TABLE geo.mv_gaul_eez TO h05mandand;
GRANT ALL ON TABLE geo.mv_gaul_eez TO h05ibex;
GRANT SELECT ON TABLE geo.mv_gaul_eez TO h05ibexro;

-- geo.mv_gaul_eez_dissolved
DROP MATERIALIZED VIEW IF EXISTS geo.mv_gaul_eez_dissolved CASCADE;
CREATE MATERIALIZED VIEW geo.mv_gaul_eez_dissolved AS SELECT * FROM geo.gaul_eez_dissolved_last;
COMMENT ON MATERIALIZED VIEW geo.mv_gaul_eez_dissolved IS 'provides (read only by all) last  GAUL-EEZ geometries dissolved; used for analysis|GEOGRAPHIC|';
CREATE UNIQUE INDEX mv_gaul_eez_dissolved_cid_idx ON geo.mv_gaul_eez_dissolved USING btree(country_id);
CREATE INDEX mv_gaul_eez_dissolved_geom_idx ON geo.mv_gaul_eez_dissolved USING gist(geom);
GRANT ALL ON TABLE geo.mv_gaul_eez_dissolved TO h05mandand;
GRANT ALL ON TABLE geo.mv_gaul_eez_dissolved TO h05ibex;
GRANT SELECT ON TABLE geo.mv_gaul_eez_dissolved TO h05ibexro;

-- geo.mv_wdpa
DROP MATERIALIZED VIEW IF EXISTS geo.mv_wdpa CASCADE;
CREATE MATERIALIZED VIEW geo.mv_wdpa AS SELECT * FROM geo.wdpa_last;
COMMENT ON MATERIALIZED VIEW geo.mv_wdpa IS 'provides (read only by all) last WDPA geometries|GEOGRAPHIC|';
CREATE UNIQUE INDEX mv_wdpa_wdpaid_idx ON geo.mv_wdpa USING btree (wdpaid);
CREATE INDEX mv_wdpa_geom_idx ON geo.mv_wdpa USING gist(geom);
GRANT ALL ON TABLE geo.mv_wdpa TO h05mandand;
GRANT ALL ON TABLE geo.mv_wdpa TO h05ibex;
GRANT SELECT ON TABLE geo.mv_wdpa TO h05ibexro;

-- geo.mv_ecoregions
DROP MATERIALIZED VIEW IF EXISTS geo.mv_ecoregions CASCADE;
CREATE MATERIALIZED VIEW geo.mv_ecoregions AS SELECT * FROM geo.ecoregions_last;
COMMENT ON MATERIALIZED VIEW geo.mv_ecoregions IS 'provides (read only by all) last ecoregions geometries|GEOGRAPHIC|';
CREATE UNIQUE INDEX mv_ecoregions_flcode_idx ON geo.mv_ecoregions USING btree(first_level_code);
CREATE INDEX mv_ecoregions_geom_idx ON geo.mv_ecoregions USING gist(geom);
GRANT ALL ON TABLE geo.mv_ecoregions TO h05mandand;
GRANT ALL ON TABLE geo.mv_ecoregions TO h05ibex;
GRANT SELECT ON TABLE geo.mv_ecoregions TO h05ibexro;






