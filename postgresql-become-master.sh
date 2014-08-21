#!/usr/bin/env bash

# Script exit codes:
# 0 - PostgreSQL is OK and is slave
# 1 - PostgreSQL is already master

PG_PATH='/var/lib/postgresql'
PG_VER="${1:-9.1}"
PG_CLUSTER="${2:-main}"

/usr/bin/pg_ctlcluster "${PG_VER}" "${PG_CLUSTER}" promote 

exit 0