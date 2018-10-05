#!/bin/bash

# SET SOME VARIABLES
## paths
ipath="inputs"
opath="outputs"
SQL="sql"

## database parameters
HOST="pgsql96-srv1.jrc.org"
USER="h05mandand"
DB="d6dopadev"
dbpar1="host=${HOST} user=${USER} dbname=${DB}"
dbpar2="-h ${HOST} -U ${USER} -d ${DB}"

dat=`date +%Y%m%d`

#REFRESH MATERIALIZED VIEW CONCURRENTLY geo.mv_country_atts
psql ${dbpar2} -c "REFRESH MATERIALIZED VIEW CONCURRENTLY geo.mv_country_atts;"
# UPDATE TRACKER TABLE
echo "DELETE FROM utils.tracker WHERE \"schema\"='geo' AND \"table\"='mv_country_atts'" | psql ${dbpar2};
echo "INSERT INTO utils.tracker (\"role\",\"schema\",\"table\",\"date\") VALUES ('${USER}','geo','mv_country_atts',${dat})" | psql ${dbpar2};
echo "geo.mv_country_atts refreshed"

#REFRESH MATERIALIZED VIEW CONCURRENTLY geo.mv_gaul_eez
psql ${dbpar2} -c "REFRESH MATERIALIZED VIEW CONCURRENTLY geo.mv_gaul_eez;"
# UPDATE TRACKER TABLE
echo "DELETE FROM utils.tracker WHERE \"schema\"='geo' AND \"table\"='mv_gaul_eez'" | psql ${dbpar2};
echo "INSERT INTO utils.tracker (\"role\",\"schema\",\"table\",\"date\") VALUES ('${USER}','geo','mv_gaul_eez',${dat})" | psql ${dbpar2};
echo "geo.mv_gaul_eez refreshed"

#REFRESH MATERIALIZED VIEW CONCURRENTLY geo.mv_gaul_eez_dissolved
psql ${dbpar2} -c "REFRESH MATERIALIZED VIEW CONCURRENTLY geo.mv_gaul_eez_dissolved;"
# UPDATE TRACKER TABLE
echo "DELETE FROM utils.tracker WHERE \"schema\"='geo' AND \"table\"='mv_gaul_eez_dissolved'" | psql ${dbpar2};
echo "INSERT INTO utils.tracker (\"role\",\"schema\",\"table\",\"date\") VALUES ('${USER}','geo','mv_gaul_eez_dissolved',${dat})" | psql ${dbpar2};
echo "geo.mv_gaul_eez_dissolved refreshed"

#REFRESH MATERIALIZED VIEW CONCURRENTLY geo.mv_wdpa
psql ${dbpar2} -c "REFRESH MATERIALIZED VIEW CONCURRENTLY geo.mv_wdpa;"
# UPDATE TRACKER TABLE
echo "DELETE FROM utils.tracker WHERE \"schema\"='geo' AND \"table\"='mv_wdpa'" | psql ${dbpar2};
echo "INSERT INTO utils.tracker (\"role\",\"schema\",\"table\",\"date\") VALUES ('${USER}','geo','mv_wdpa',${dat})" | psql ${dbpar2};
echo "geo.mv_wdpa refreshed"

#REFRESH MATERIALIZED VIEW CONCURRENTLY geo.mv_ecoregions
psql ${dbpar2} -c "REFRESH MATERIALIZED VIEW CONCURRENTLY geo.mv_ecoregions;"
# UPDATE TRACKER TABLE
echo "DELETE FROM utils.tracker WHERE \"schema\"='geo' AND \"table\"='mv_ecoregions'" | psql ${dbpar2};
echo "INSERT INTO utils.tracker (\"role\",\"schema\",\"table\",\"date\") VALUES ('${USER}','geo','mv_ecoregions',${dat})" | psql ${dbpar2};
echo "geo.mv_ecoregions refreshed"




