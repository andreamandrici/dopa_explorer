#!/bin/bash

# SET SOME VARIABLES
## paths
ipath="input"
opath="outputs"
SQL="sql"

## database parameters
HOST="pgsql96-srv1.jrc.org"
USER="h05mandand"
DB="d6dopadev"
dbpar1="host=${HOST} user=${USER} dbname=${DB}"
dbpar2="-h ${HOST} -U ${USER} -d ${DB}"

# # SQL PART

# ## protected_sites

# # main wdpa table
# psql ${dbpar2} -f ${SQL}/"protected_sites_wdpa.sql"

# # dopa_geoserver_wdpa_master
# ## DEPENDANT FROM administrative_units.country_codes_iso
# psql ${dbpar2} -f ${SQL}/"protected_sites_wdpa_geoserver.sql"

# # dopa_drupal_wdpa_master
# ## DEPENDANT FROM administrative_units.country_codes_iso 
# psql ${dbpar2} -f ${SQL}/"protected_sites_wdpa_drupal.sql"

# # wdpa_centroids
# psql ${dbpar2} -f ${SQL}/"protected_sites_wdpa_centroids.sql"
# export wdpa_centroids to CSV
echo "\copy protected_sites.wdpa_centroids TO ${opath}/wdpa_centroids.csv delimiter '|' CSV HEADER;" | psql ${dbpar2};
