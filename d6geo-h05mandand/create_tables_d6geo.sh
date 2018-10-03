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

## countries
### country_atts materialized view
psql ${dbpar2} -f ${SQL}/"country_atts.sql"

## wdpa
### wdpa materialized view
psql ${dbpar2} -f ${SQL}/"wdpa.sql"
