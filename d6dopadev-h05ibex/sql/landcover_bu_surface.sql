-- CREATE TABLE landcover.bu_surface
DROP TABLE IF EXISTS landcover.bu_surface;
CREATE TABLE landcover.bu_surface (
  wdpaid integer,
  bu_surface double precision
);

GRANT ALL ON TABLE landcover.bu_surface TO h05mandand;
GRANT ALL ON TABLE landcover.bu_surface TO h05ibex;
GRANT SELECT ON TABLE landcover.bu_surface TO h05ibexro;

-- CREATE FUNCTION landcover.bu_surface
