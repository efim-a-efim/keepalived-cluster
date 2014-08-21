#!/usr/bin/env bash

PG_PATH='/var/lib/postgresql'
PG_VER="${1:-9.1}"
PG_CLUSTER="${2:-main}"

# Prepare slave
[[ -f "${PG_PATH}/${PG_VER}/${PG_CLUSTER}/recovery.done" ]] && \
		mv "${PG_PATH}/${PG_VER}/${PG_CLUSTER}/recovery.done" "${PG_PATH}/${PG_VER}/${PG_CLUSTER}/recovery.conf"
# restart PostgreSQL as slave
/etc/init.d/postgresql restart