-- CREATE TABLE landcover.pa_lc_1995_2015
DROP TABLE IF EXISTS landcover.pa_lc_1995_2015;
CREATE TABLE landcover.pa_lc_1995_2015 (
	wdpaid integer NOT NULL,
	lc_code integer NOT NULL,
	"1995" double precision,
	"2000" double precision,
	"2005" double precision,
	"2010" double precision,
	"2015" double precision
);

GRANT ALL ON TABLE landcover.pa_lc_1995_2015 TO h05mandand;
GRANT ALL ON TABLE landcover.pa_lc_1995_2015 TO h05ibex;
GRANT SELECT ON TABLE landcover.pa_lc_1995_2015 TO h05ibexro;

-- CREATE FUNCTION landcover.pa_lc_1995_2015
