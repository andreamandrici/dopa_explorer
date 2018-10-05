-- CREATE TABLE pressures.road_pa
DROP TABLE IF EXISTS pressures.road_pa;
CREATE TABLE pressures.road_pa (
wdpaid integer,
non_null_cells integer,
null_cells bigint,
min double precision,
max double precision,
range double precision,
ind double precision, -- this is the mean value
mean_of_abs double precision,
stddev double precision,
variance double precision,
coeff_var double precision,
sum numeric(20,4),
sum_abs numeric(20,4),
first_quart double precision,
median double precision,
third_quart double precision,
perc_90 double precision
);

GRANT ALL ON TABLE pressures.road_pa TO h05mandand;
GRANT ALL ON TABLE pressures.road_pa TO h05ibex;
GRANT SELECT ON TABLE pressures.road_pa TO h05ibexro;

-- CREATE FUNCTION pressures.road_pa
