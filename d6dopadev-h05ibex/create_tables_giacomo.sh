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


# INDICATORS
## create table builtup.bu_pa
psql ${dbpar2} -f ${SQL}/builtup_bu_pa.sql

### create table builtup.bu_bu				##DA CALCOLARE, manca il csv, waiting for Marletta
#psql ${dbpar2} -f ${SQL}/builtup_bu_bu.sql	##DA CALCOLARE, manca il csv, waiting for Marletta

## create table climate.copernicus_sst_wdpa
psql ${dbpar2} -f ${SQL}/climate_copernicus_sst_wdpa.sql

## create table climate.worldclim_wdpa
psql ${dbpar2} -f ${SQL}/climate_worldclim_wdpa.sql

## create table hdi.hdi_wdpa
psql ${dbpar2} -f ${SQL}/hdi_hdi_wdpa.sql

## create table landcover.pa_lc_1995_2015
psql ${dbpar2} -f ${SQL}/landcover_pa_lc_1995_2015.sql

## create table landcover.pa_surface
psql ${dbpar2} -f ${SQL}/landcover_pa_surface.sql

## create table landcover.bu_lc_1995_2015
psql ${dbpar2} -f ${SQL}/landcover_bu_lc_1995_2015.sql

## create table landcover.bu_surface
psql ${dbpar2} -f ${SQL}/landcover_bu_surface.sql

## create table landcover.pa_lcc_1995_2015
psql ${dbpar2} -f ${SQL}/landcover_pa_lcc_1995_2015.sql

## create table landcover.bu_lcc_1995_2015
psql ${dbpar2} -f ${SQL}/landcover_bu_lcc_1995_2015.sql

## create table pressures.agriculture_pa
psql ${dbpar2} -f ${SQL}/pressures_agriculture_pa.sql

## create table pressures.pop_density_pa
psql ${dbpar2} -f ${SQL}/pressures_pop_density_pa.sql

## create table pressures.pa_popchange
psql ${dbpar2} -f ${SQL}/pressures_pop_change_pa.sql

## create table pressures.pa_popdenschange
psql ${dbpar2} -f ${SQL}/pressures_pop_denschange_pa.sql

## create table pressures.road_pa
psql ${dbpar2} -f ${SQL}/pressures_road_pa.sql

## create table topography.gebco_wdpa
psql ${dbpar2} -f ${SQL}/topography_gebco_wdpa.sql
