Scripts to update d6geo (as admin).

Execute:
*  **create_materialized_views_d6geo.sh** script to drop/create:
  *  "_latest" functions (select the last object according to *\_yyyymmdd_version in name)
  *  "_last" materialized views (last objects in the schema geo.*)
*  **refresh_materialized_views_d6geo.sh** script to:
  *  refresh the geo.* objects and update them to the last version.