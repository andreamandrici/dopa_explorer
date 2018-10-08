Scripts to update d6dopadev (as user).

After admin has updated the materialized views (see in ../d6dopadev_admin), with following sequence compulsory:

1.  On dev stage: 
    *  ./a1_create_main_tables_d6dopadev_user.sh
    *  ./a2_create_derived_tables_d6dopadev_user.sh
    *  ./a3_create_indicators_tables_d6dopadev_user.sh

2.  On update stage: edit in the following scripts the lists of tables to be updated, then:
    *  ./b1_update_main_tables_d6dopadev_user.sh
    *  ./b2_update_derived_tables_d6dopadev_user.sh
    *  ./b3_update_indicators_tables_d6dopadev_user.sh
