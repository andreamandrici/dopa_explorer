-- CENTROIDS TABLE
DROP TABLE IF EXISTS protected_sites.wdpa_centroids CASCADE;
CREATE TABLE protected_sites.wdpa_centroids AS
SELECT
wdpaid,
name::text,
st_pointonsurface(geom) the_geom
FROM protected_sites.wdpa
WHERE area_geo >= 25::double precision;
ALTER TABLE protected_sites.wdpa_centroids
ADD PRIMARY KEY (wdpaid),
ALTER COLUMN the_geom type geometry(Point,4326);
GRANT ALL ON TABLE protected_sites.wdpa_centroids TO h05ibex;
GRANT SELECT ON TABLE protected_sites.wdpa_centroids TO h05ibexro;
COMMENT ON TABLE protected_sites.wdpa_centroids IS 'last version of wdpa over 25 sqkm (points)|TRUE|CARTO';