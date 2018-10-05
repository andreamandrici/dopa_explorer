-- CREATE TABLE landcover.pa_lcc_1995_2015
DROP TABLE IF EXISTS landcover.pa_lcc_1995_2015;
CREATE TABLE landcover.pa_lcc_1995_2015 (
	wdpaid integer NOT NULL,
	"1995" integer NOT NULL,
	"2015" integer NOT NULL,
	sqkm numeric
);

GRANT ALL ON TABLE landcover.pa_lcc_1995_2015 TO h05mandand;
GRANT ALL ON TABLE landcover.pa_lcc_1995_2015 TO h05ibex;
GRANT SELECT ON TABLE landcover.pa_lcc_1995_2015 TO h05ibexro;

-- CREATE FUNCTION landcover.pa_lcc_1995_2015
