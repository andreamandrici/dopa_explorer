-- CREATE TABLE pressures.pa_popdenschange
DROP TABLE IF EXISTS pressures.pa_popdenschange;
CREATE TABLE pressures.pa_popdenschange (
  wdpaid integer NOT NULL,
  ind numeric
);

GRANT ALL ON TABLE pressures.pa_popdenschange TO h05mandand;
GRANT ALL ON TABLE pressures.pa_popdenschange TO h05ibex;
GRANT SELECT ON TABLE pressures.pa_popdenschange TO h05ibexro;

-- CREATE FUNCTION pressures.pa_popdenschange
