-- CREATE TABLE landcover.pa_surface
DROP TABLE IF EXISTS landcover.pa_surface;
CREATE TABLE landcover.pa_surface (
  wdpaid integer,
  pa_surface double precision
);

GRANT ALL ON TABLE landcover.pa_surface TO h05mandand;
GRANT ALL ON TABLE landcover.pa_surface TO h05ibex;
GRANT SELECT ON TABLE landcover.pa_surface TO h05ibexro;

-- CREATE FUNCTION landcover.pa_surface
