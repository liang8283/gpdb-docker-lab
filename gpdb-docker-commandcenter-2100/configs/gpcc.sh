#!/bin/bash

export MASTER_DATA_DIRECTORY=/data/master/gpseg-1
source /usr/local/greenplum-db/greenplum_path.sh
source /usr/local/greenplum-cc-web/gpcc_path.sh
gpstart -a

# Detect/Create GPCC Objects on Start
result=`psql -d gpadmin -t -c "select count(*) from (select 1 from pg_roles where rolname='gpmon')z"`
if [ $result == 0 ]; then
  echo "Setting up GPCC"
  echo "host all all 0.0.0.0/0 trust" >> /data/master/gpseg-1/pg_hba.conf
  echo "host all gpmon samenet trust" >> /data/master/gpseg-1/pg_hba.conf
  gpstop -u
#  echo 'changeme\nchangeme\n'|createuser -s -l gpmon
#  createdb gpperfmon
  gpperfmon_install --enable --password changeme --port 5432
  gpstop -af
  gpstart -a
  /usr/local/greenplum-cc-web/bin/gpcmdr --setup --config_file /tmp/gpcmdr.conf
fi

# Start up GPCC Instance
/usr/local/greenplum-cc-web/bin/gpcmdr --start gpdb_docker
