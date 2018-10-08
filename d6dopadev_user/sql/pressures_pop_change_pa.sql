-- CREATE TABLE pressures.pa_popchange
DROP TABLE IF EXISTS pressures.pa_popchange;
CREATE TABLE pressures.pa_popchange (
  wdpaid integer NOT NULL,
  ind numeric
);

GRANT ALL ON TABLE pressures.pa_popchange TO h05mandand;
GRANT ALL ON TABLE pressures.pa_popchange TO h05ibex;
GRANT SELECT ON TABLE pressures.pa_popchange TO h05ibexro;

-- CREATE FUNCTION pressures.pa_popchange
