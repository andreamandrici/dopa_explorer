-- WDPA GEOSERVER TABLE

DROP TABLE IF EXISTS protected_sites.dopa_geoserver_wdpa_master CASCADE;
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
