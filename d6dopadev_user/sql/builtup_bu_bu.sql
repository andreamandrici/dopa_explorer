-- CREATE TABLE builtup.bu_bu
DROP TABLE IF EXISTS builtup.bu_bu;
CREATE TABLE builtup.bu_bu (
  wdpaid integer,
  val integer,
  val_km double precision,
  area_bu_km2 double precision
);

GRANT ALL ON TABLE builtup.bu_bu TO h05mandand;
GRANT ALL ON TABLE builtup.bu_bu TO h05ibex;
GRANT SELECT ON TABLE builtup.bu_bu TO h05ibexro;

-- CREATE FUNCTION builtup.bu_bu
