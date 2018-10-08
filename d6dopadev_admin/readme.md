Scripts to update d6dopadev (as admin).

Before running these scripts refresh materialized views in d6geo (../d6geo_admin).

Execute:
*  **create_foreign_tables_d6dopadev_admin.sh** script to drop/create:
    *  "_last" foreign data tables (*._last objects in the schema geo.*, taken from d6geo)
    *  "mv_" materialized views (mv_objects in the schema geo.*, readable by all, taken by above foreign data tables)
*  **refresh_materialized_views_d6dopadev_admin.sh** script to:
    *  refresh the geo.mv_* objects and update them to the last version.

