-- MAIN TABLE
DROP TABLE IF EXISTS protected_sites.wdpa CASCADE;

CREATE TABLE protected_sites.wdpa AS SELECT * FROM geo.wdpa;
ALTER TABLE protected_sites.wdpa ADD PRIMARY KEY (wdpaid);

GRANT ALL ON TABLE protected_sites.wdpa TO h05mandand;
GRANT SELECT ON TABLE protected_sites.wdpa TO h05ibexro;
GRANT SELECT ON TABLE protected_sites.wdpa TO h05ibex;

COMMENT ON TABLE protected_sites.wdpa IS 'last version of wdpa (poly)|TRUE';

CREATE INDEX wdpa_geom_idx ON protected_sites.wdpa USING gist(geom);
CREATE INDEX wdpa_iso3_idx ON protected_sites.wdpa USING btree(iso3);
CREATE INDEX wdpa_marine_idx ON protected_sites.wdpa USING btree(marine);
CREATE INDEX wdpa_wdpaid_idx ON protected_sites.wdpa USING btree(wdpaid);

-- GEOSERVER TABLE

DROP TABLE IF EXISTS protected_sites.dopa_geoserver_wdpa_master;
CREATE TABLE protected_sites.dopa_geoserver_wdpa_master AS
 WITH unnested AS (
         SELECT a_1.wdpaid,
            unnest(string_to_array(a_1.iso3::text, ';'::text)) AS iso3
           FROM protected_sites.wdpa a_1
          WHERE a_1.area_geo >= 25::double precision AND a_1.iso3::text ~~ '%;%'::text
        ), renested AS (
         SELECT a_1.wdpaid,
            array_to_string(array_agg(a_1.iso3), '|'::text) AS iso3,
            array_to_string(array_agg(b_1.iso2), '|'::text) AS iso_2_code,
            array_to_string(array_agg(b_1.un_m49), '|'::text) AS iso3_num,
            array_to_string(array_agg(b_1.english_name), '|'::text) AS country
           FROM unnested a_1
             LEFT JOIN administrative_units.country_codes_iso b_1 ON a_1.iso3 = b_1.iso3::text
          GROUP BY a_1.wdpaid
        ), originals AS (
         SELECT a_1.wdpaid,
            a_1.iso3::text AS iso3,
            b_1.iso2::text AS iso_2_code,
            b_1.un_m49::text AS iso3_num,
            b_1.english_name::text AS country
           FROM protected_sites.wdpa a_1
             LEFT JOIN administrative_units.country_codes_iso b_1 ON a_1.iso3::text = b_1.iso3::text
          WHERE a_1.area_geo >= 25::double precision AND a_1.iso3::text !~~ '%;%'::text AND a_1.type::text = 'Polygon'::text
        ), merged AS (
         SELECT originals.wdpaid,
            originals.iso3,
            originals.iso_2_code,
            originals.iso3_num,
            originals.country
           FROM originals
        UNION
         SELECT renested.wdpaid,
            renested.iso3,
            renested.iso_2_code,
            renested.iso3_num,
            renested.country
           FROM renested
        )
 SELECT a.wdpaid,
    a.iso3,
    a.iso_2_code,
    a.iso3_num,
    a.country,
    b.wdpa_pid,
    b.name AS wdpa_name,
    b.desig,
    b.desig_eng,
    b.desig_type,
    b.status_yr,
    b.status,
    b.iucn_cat,
    b.gov_type,
    b.own_type,
    b.marine,
    round(b.rep_m_area::numeric, 1) AS rep_m_area,
    round(b.area_geo::numeric, 1) AS jrc_gis_area_km2,
    b.mang_auth,
    b.verif,
    round(b.rep_area::numeric, 1) AS rep_area,
    b.geom
   FROM merged a
     LEFT JOIN protected_sites.wdpa b ON a.wdpaid = b.wdpaid
  ORDER BY a.wdpaid;

GRANT ALL ON TABLE protected_sites.dopa_geoserver_wdpa_master TO h05ibex;
GRANT SELECT ON TABLE protected_sites.dopa_geoserver_wdpa_master TO h05ibexro;

COMMENT ON TABLE protected_sites.dopa_geoserver_wdpa_master IS 'last version of wdpa over 25 sqkm (poly)|TRUE|GEOSERVER';

CREATE INDEX dopa_geoserver_wdpa_master_geom_idx
    ON protected_sites.dopa_geoserver_wdpa_master USING gist(geom);
CREATE INDEX dopa_geoserver_wdpa_master_un_m49_idx
    ON protected_sites.dopa_geoserver_wdpa_master USING btree(iso3_num);
CREATE INDEX dopa_geoserver_wdpa_master_wdpaid_idx
    ON protected_sites.dopa_geoserver_wdpa_master USING btree(wdpaid);

-- DRUPAL TABLE
DROP TABLE IF EXISTS protected_sites.dopa_drupal_wdpa_master;
CREATE TABLE protected_sites.dopa_drupal_wdpa_master AS
 WITH unnested AS (
         SELECT a_1.wdpaid,
            unnest(string_to_array(a_1.iso3::text, ';'::text)) AS iso3
           FROM protected_sites.wdpa a_1
          WHERE a_1.area_geo >= 25::double precision AND a_1.iso3::text ~~ '%;%'::text
        ), renested AS (
         SELECT a_1.wdpaid,
            array_to_string(array_agg(a_1.iso3), '|'::text) AS iso3,
            array_to_string(array_agg(b_1.iso2), '|'::text) AS iso_2_code,
            array_to_string(array_agg(b_1.un_m49), '|'::text) AS iso3_num,
            array_to_string(array_agg(b_1.english_name), '|'::text) AS country
           FROM unnested a_1
             LEFT JOIN administrative_units.country_codes_iso b_1 ON a_1.iso3 = b_1.iso3::text
          GROUP BY a_1.wdpaid
        ), originals AS (
         SELECT a_1.wdpaid,
            a_1.iso3::text AS iso3,
            b_1.iso2::text AS iso_2_code,
            b_1.un_m49::text AS iso3_num,
            b_1.english_name::text AS country
           FROM protected_sites.wdpa a_1
             LEFT JOIN administrative_units.country_codes_iso b_1 ON a_1.iso3::text = b_1.iso3::text
          WHERE a_1.area_geo >= 25::double precision AND a_1.iso3::text !~~ '%;%'::text AND a_1.type::text = 'Polygon'::text
        ), merged AS (
         SELECT originals.wdpaid,
            originals.iso3,
            originals.iso_2_code,
            originals.iso3_num,
            originals.country
           FROM originals
        UNION
         SELECT renested.wdpaid,
            renested.iso3,
            renested.iso_2_code,
            renested.iso3_num,
            renested.country
           FROM renested
        )
 SELECT a.wdpaid,
    a.iso3,
    a.iso_2_code,
    a.iso3_num,
    a.country,
    b.name AS wdpa_name,
    b.desig,
    b.desig_type,
    b.status_yr,
    b.iucn_cat,
    b.marine,
    round(b.area_geo::numeric, 1) AS jrc_gis_area_km2,
    b.mang_auth,
    round(b.rep_area::numeric, 1) AS rep_area,
    st_asewkt(st_simplifypreservetopology(b.geom, 0.001::double precision)) AS geom
   FROM merged a
     LEFT JOIN protected_sites.wdpa b ON a.wdpaid = b.wdpaid
  ORDER BY a.wdpaid;

GRANT ALL ON TABLE protected_sites.dopa_drupal_wdpa_master TO h05ibex;
GRANT SELECT ON TABLE protected_sites.dopa_drupal_wdpa_master TO h05ibexro;
COMMENT ON TABLE protected_sites.dopa_drupal_wdpa_master IS 'Last version of wdpa over 25 sqkm (simplified poly)|TRUE|DRUPAL';										  

-- CENTROIDS TABLE										  
CREATE TABLE protected_sites.wdpa_centroids AS
SELECT
wdpaid,
name::text,
st_pointonsurface(geom) the_geom
FROM protected_sites.wdpa
WHERE area_geo >= 25::double precision;
ALTER TABLE protected_sites.wdpa_centroids ADD PRIMARY KEY (wdpaid);
GRANT ALL ON TABLE protected_sites.wdpa_centroids TO h05ibex;
GRANT SELECT ON TABLE protected_sites.wdpa_centroids TO h05ibexro;
COMMENT ON TABLE protected_sites.wdpa_centroids IS 'last version of wdpa over 25 sqkm (points)|TRUE|CARTO';
