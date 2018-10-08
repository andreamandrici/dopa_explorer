-- CREATE TABLE schema.indicator
DROP TABLE IF EXISTS climate.copernicus_sst_wdpa;
CREATE TABLE climate.copernicus_sst_wdpa (
  wdpaid integer,
  tmean_jan double precision,
  tmean_feb double precision,
  tmean_mar double precision,
  tmean_apr double precision,
  tmean_may double precision,
  tmean_jun double precision,
  tmean_jul double precision,
  tmean_aug double precision,
  tmean_sep double precision,
  tmean_oct double precision,
  tmean_nov double precision,
  tmean_dec double precision,
  tmin_jan double precision,
  tmin_feb double precision,
  tmin_mar double precision,
  tmin_apr double precision,
  tmin_may double precision,
  tmin_jun double precision,
  tmin_jul double precision,
  tmin_aug double precision,
  tmin_sep double precision,
  tmin_oct double precision,
  tmin_nov double precision,
  tmin_dec double precision,
  tmax_jan double precision,
  tmax_feb double precision,
  tmax_mar double precision,
  tmax_apr double precision,
  tmax_may double precision,
  tmax_jun double precision,
  tmax_jul double precision,
  tmax_aug double precision,
  tmax_sep double precision,
  tmax_oct double precision,
  tmax_nov double precision,
  tmax_dec double precision
);

GRANT ALL ON TABLE climate.copernicus_sst_wdpa TO h05mandand;
GRANT ALL ON TABLE climate.copernicus_sst_wdpa TO h05ibex;
GRANT SELECT ON TABLE climate.copernicus_sst_wdpa TO h05ibexro;

-- CREATE FUNCTION climate.copernicus_sst_wdpa
