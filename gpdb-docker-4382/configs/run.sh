#!/bin/bash

echo "host all all 0.0.0.0/0 trust" >> /data/master/gpseg-1/pg_hba.conf
export MASTER_DATA_DIRECTORY=/data/master/gpseg-1
source /usr/local/greenplum-db/greenplum_path.sh
gpstart -a
psql -d template1 -c "alter user gpadmin password 'changeme'"
