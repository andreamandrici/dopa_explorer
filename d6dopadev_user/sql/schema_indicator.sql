-- CREATE TABLE schema.indicator
DROP TABLE IF EXISTS schema.indicator;
CREATE TABLE schema.indicator (
	wdpaid integer NOT NULL,
	lc_code integer NOT NULL
);

GRANT ALL ON TABLE schema.indicator TO h05mandand;
GRANT ALL ON TABLE schema.indicator TO h05ibex;
GRANT SELECT ON TABLE schema.indicator TO h05ibexro;

-- CREATE FUNCTION schema.indicator
