#!/bin/bash

echo "host all all 0.0.0.0/0 trust" >> /data/master/gpseg-1/pg_hba.conf
export MASTER_DATA_DIRECTORY=/data/master/gpseg-1
source /usr/local/greenplum-db/greenplum_path.sh
source /usr/local/greenplum-cc-web/gpcc_path.sh 
gpstart -a
gpcmdr --start gpdb_docker 
