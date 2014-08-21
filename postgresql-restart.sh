#!/usr/bin/env bash

# Script exit codes:
# 0 - PostgreSQL is OK and is slave
# 1 - PostgreSQL is already master

PG_PATH='/var/lib/postgresql'
PG_VER="${1:-9.1}"
PG_CLUSTER="${2:-main}"

# If postgres is dead, restart it
_res=`sudo -u postgres psql -d postgres -q -t -c 'select 1;' | head -n 1 | tr -d ' '`
if [[ $? -ne 0 ]] || [[ "${_res}" != "1" ]]; then
	[[ -f "${PG_PATH}/${PG_VER}/${PG_CLUSTER}/recovery.done" ]] && \
		mv "${PG_PATH}/${PG_VER}/${PG_CLUSTER}/recovery.done" "${PG_PATH}/${PG_VER}/${PG_CLUSTER}/recovery.conf"	
	/etc/init.d/postgresql stop && sleep 2 && /etc/init.d/postgresql start
fi

# Exit with 1 if we-re already master
_res=`sudo -u postgres psql -U postgres -d postgres -q -t -c 'select pg_is_in_recovery();' | head -n 1 | tr -d ' '`
[[ $? -le 0 ]] && [[ "${_res}" = "f" ]] && exit 1

exit 0