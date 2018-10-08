#!/bin/bash

# SET SOME VARIABLES
## paths
ipath="inputs"
opath="outputs"
SQL="sql"

## database parameters
HOST="pgsql96-srv2.jrc.org"
USER="h05mandand"
DB="d6geo"
dbpar1="host=${HOST} user=${USER} dbname=${DB}"
dbpar2="-h ${HOST} -U ${USER} -d ${DB}"

dat=`date +%Y%m%d`

#REFRESH MATERIALIZED VIEW CONCURRENTLY geo.country_atts_last
psql ${dbpar2} -c "REFRESH MATERIALIZED VIEW CONCURRENTLY geo.country_atts_last;"
# UPDATE TRACKER TABLE
echo "DELETE FROM utils.tracker WHERE \"schema\"='geo' AND \"table\"='country_atts_last'" | psql ${dbpar2};
echo "INSERT INTO utils.tracker (\"schema\",\"table\",\"date\") VALUES ('geo','country_atts_last',${dat})" | psql ${dbpar2};
echo "geo.country_atts_last refreshed"

# #REFRESH MATERIALIZED VIEW CONCURRENTLY geo.gaul_eez_last
# psql ${dbpar2} -c "REFRESH MATERIALIZED VIEW CONCURRENTLY geo.gaul_eez_last;"
# # UPDATE TRACKER TABLE
# echo "DELETE FROM utils.tracker WHERE \"schema\"='geo' AND \"table\"='gaul_eez_last'" | psql ${dbpar2};
# echo "INSERT INTO utils.tracker (\"schema\",\"table\",\"date\") VALUES ('geo','gaul_eez_last',${dat})" | psql ${dbpar2};
# echo "geo.gaul_eez_last refreshed"

# #REFRESH MATERIALIZED VIEW CONCURRENTLY geo.gaul_eez_dissolved_last
# psql ${dbpar2} -c "REFRESH MATERIALIZED VIEW CONCURRENTLY geo.gaul_eez_dissolved_last;"
# # UPDATE TRACKER TABLE
# echo "DELETE FROM utils.tracker WHERE \"schema\"='geo' AND \"table\"='gaul_eez_dissolved_last'" | psql ${dbpar2};
# echo "INSERT INTO utils.tracker (\"schema\",\"table\",\"date\") VALUES ('geo','gaul_eez_dissolved_last',${dat})" | psql ${dbpar2};
# echo "geo.gaul_eez_dissolved_last refreshed"

# #REFRESH MATERIALIZED VIEW CONCURRENTLY geo.wdpa_last
# psql ${dbpar2} -c "REFRESH MATERIALIZED VIEW CONCURRENTLY geo.wdpa_last;"
# # UPDATE TRACKER TABLE
# echo "DELETE FROM utils.tracker WHERE \"schema\"='geo' AND \"table\"='wdpa_last'" | psql ${dbpar2};
# echo "INSERT INTO utils.tracker (\"schema\",\"table\",\"date\") VALUES ('geo','wdpa_last',${dat})" | psql ${dbpar2};
# echo "geo.wdpa_last refreshed"

# #REFRESH MATERIALIZED VIEW CONCURRENTLY geo.ecoregions_last
# psql ${dbpar2} -c "REFRESH MATERIALIZED VIEW CONCURRENTLY geo.ecoregions_last;"
# # UPDATE TRACKER TABLE
# echo "DELETE FROM utils.tracker WHERE \"schema\"='geo' AND \"table\"='ecoregions_last'" | psql ${dbpar2};
# echo "INSERT INTO utils.tracker (\"schema\",\"table\",\"date\") VALUES ('geo','ecoregions_last',${dat})" | psql ${dbpar2};
# echo "geo.ecoregions_last refreshed"



