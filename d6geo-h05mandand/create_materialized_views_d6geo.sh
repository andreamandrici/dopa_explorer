#!/bin/bash

# SET SOME VARIABLES
## paths
ipath="input"
opath="outputs"
SQL="sql"

## database parameters
HOST="pgsql96-srv2.jrc.org"
USER="h05mandand"
DB="d6geo"
dbpar1="host=${HOST} user=${USER} dbname=${DB}"
dbpar2="-h ${HOST} -U ${USER} -d ${DB}"

# SQL PART

# UTILS
## create table utils.tracker
psql ${dbpar2} -f ${SQL}/utils_tracker.sql

## countries

### country_atts_last materialized view
psql ${dbpar2} -f ${SQL}/"country_atts_last.sql"

### gaul_eez_last materialized view
psql ${dbpar2} -f ${SQL}/"gaul_eez_last.sql"

### gaul_eez_dissolved_last materialized view
psql ${dbpar2} -f ${SQL}/"gaul_eez_dissolved_last.sql"

## wdpa

### wdpa_last materialized view
psql ${dbpar2} -f ${SQL}/"wdpa_last.sql"

## ecoregions

### ecoregions_last materialized view
psql ${dbpar2} -f ${SQL}/"ecoregions_last.sql"

