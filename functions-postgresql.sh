#!/usr/bin/env bash

# check PostgreSQL connection and sample query
check_psql_connect() {
	local _res=`sudo -u postgres psql -U postgres -h "${1:-localhost}" -d postgres -q -t -c 'select 1;' | head -n 1 | tr -d ' '`
	[[ $? -le 0 ]] && [[ "${_res}" = "1" ]] && return 0
	return 1
}

# returns 0 if master, otherwise 1
check_psql_master() {
	local _res=`sudo -u postgres psql -U postgres -h "${1:-localhost}" -d postgres -q -t -c 'select pg_is_in_recovery();' | head -n 1 | tr -d ' '`
	[[ $? -le 0 ]] && [[ "${_res}" = "f" ]] && return 0
	return 1
}
