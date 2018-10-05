Scripts to update d6dopadev (as user).

After admin has updated the materialized views (see in ../d6dopadev-h05mandand):

1.  On dev stage: 
    *  ./create_main_tables_d6dopadev_user.sh
    *  ./create_indicators_tables_d6dopadev_user.sh
    
2.  On update stage: edit in the following scripts the lists of tables to be updated, then:
    *  ./update_main_tables_d6dopadev_user.sh
    *  ./update_indicators_tables_d6dopadev_user.sh
