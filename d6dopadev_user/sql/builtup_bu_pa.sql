-- CREATE TABLE builtup.bu_pa
DROP TABLE IF EXISTS builtup.bu_pa;
CREATE TABLE builtup.bu_pa (
  wdpaid integer,
  val integer,
  val_km double precision,
  area_pa_km2 double precision
);

GRANT ALL ON TABLE builtup.bu_pa TO h05mandand;
GRANT ALL ON TABLE builtup.bu_pa TO h05ibex;
GRANT SELECT ON TABLE builtup.bu_pa TO h05ibexro;

-- CREATE FUNCTION builtup.bu_pa
