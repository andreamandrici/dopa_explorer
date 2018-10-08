-- CREATE TABLE climate.worldclim_wdpa
DROP TABLE IF EXISTS climate.worldclim_wdpa;
CREATE TABLE climate.worldclim_wdpa (
wdpaid integer NOT NULL,
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
  tmax_dec double precision,
  tmean_jan double precision,
  tmean_feb double precision,
  tmean_mar double precision,
  tmean_apr double precision,
  tmean_jun double precision,
  tmean_jul double precision,
  tmean_aug double precision,
  tmean_sep double precision,
  tmean_oct double precision,
  tmean_nov double precision,
  tmean_dec double precision,
  tmean_may double precision,
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
  prec_jan double precision,
  prec_feb double precision,
  prec_mar double precision,
  prec_apr double precision,
  prec_may double precision,
  prec_jun double precision,
  prec_jul double precision,
  prec_aug double precision,
  prec_sep double precision,
  prec_oct double precision,
  prec_nov double precision,
  prec_dec double precision
);

GRANT ALL ON TABLE climate.worldclim_wdpa TO h05mandand;
GRANT ALL ON TABLE climate.worldclim_wdpa TO h05ibex;
GRANT SELECT ON TABLE climate.worldclim_wdpa TO h05ibexro;

-- CREATE FUNCTION climate.worldclim_wdpa
