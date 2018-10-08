-- CREATE TABLE hdi.hdi_wdpa
DROP TABLE IF EXISTS hdi.hdi_wdpa;
CREATE TABLE hdi.hdi_wdpa (
	wdpaid integer,
	freq integer,
	km2 double precision,
	awhd double precision
);

GRANT ALL ON TABLE hdi.hdi_wdpa TO h05mandand;
GRANT ALL ON TABLE hdi.hdi_wdpa TO h05ibex;
GRANT SELECT ON TABLE hdi.hdi_wdpa TO h05ibexro;

-- CREATE FUNCTION hdi.hdi_wdpa
