-- CREATE TABLE water.pa_water_stats
DROP TABLE IF EXISTS water.pa_water_stats;
CREATE TABLE water.pa_water_stats (
  wdpaid integer,
  perm_now_km2 double precision,
  seas_now_km2 double precision,
  net_p_change_km2 double precision,
  net_s_change_km2 double precision,
  percent_net_perm_change double precision,
  percent_net_seas_change double precision,
  perm_1985_km2 double precision,
  seas_1985_km2 double precision
);

GRANT ALL ON TABLE water.pa_water_stats TO h05mandand;
GRANT ALL ON TABLE water.pa_water_stats TO h05ibex;
GRANT SELECT ON TABLE water.pa_water_stats TO h05ibexro;

-- CREATE FUNCTION water.pa_water_stats
