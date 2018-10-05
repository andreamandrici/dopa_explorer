#!/bin/bash

# SET SOME VARIABLES
## paths
ipath="inputs"
opath="outputs"
SQL="sql"

## database parameters
HOST="pgsql96-srv1.jrc.org"
USER="h05ibex"
DB="d6dopadev"
dbpar1="host=${HOST} user=${USER} dbname=${DB}"
dbpar2="-h ${HOST} -U ${USER} -d ${DB}"

list="\
protected_sites.wdpa_centroids
"

for l in ${list}
do

	sch=`echo ${l} | cut -d'.' -f1`

	tab=`echo ${l} | cut -d'.' -f2`

	echo "going in schema " ${sch}

	echo "creating table " ${tab}

	# create_function
	psql ${dbpar2} -f ${SQL}/${sch}/f_pop_${tab}.sql;
	#create table
	psql ${dbpar2} -f ${SQL}/${sch}/${tab}.sql;
	#populate table
	echo "INSERT INTO ${sch}.${tab} SELECT * FROM ${sch}.f_pop_${tab}();" | psql ${dbpar2}

	done


# # dopa_geoserver_wdpa_master
# ## DEPENDANT FROM administrative_units.country_codes_iso
# psql ${dbpar2} -f ${SQL}/"protected_sites_wdpa_geoserver.sql"

# # dopa_drupal_wdpa_master
# ## DEPENDANT FROM administrative_units.country_codes_iso 
# psql ${dbpar2} -f ${SQL}/"protected_sites_wdpa_drupal.sql"

# EXPORT wdpa_centroids to CSV

echo "\copy protected_sites.wdpa_centroids TO ${opath}/wdpa_centroids.csv delimiter '|' CSV HEADER;" | psql ${dbpar2};
