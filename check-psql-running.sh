#!/usr/bin/env bash
PSQL_PID_FILE='/var/lib/postgresql/9.1/main/postmaster.pid'
PSQL_PORT='5432'
PSQL_USER='postgres'
PSQL_HOST=''
PSQL_LOCALIP="${1:-127.0.0.1}"
PSQL_REMOTEIP="${2:-127.0.0.1}"
LOG='/var/log/keepalived/check-psql-vrrp.log'

. /etc/keepalived/functions-common.sh || exit 1
. /etc/keepalived/functions-postgresql.sh || exit 1

# Local Postgres checks
check_pid_file "${PSQL_PID_FILE}" || exit_err 'pid_file' 1
check_listen_port "${PSQL_PORT}" || exit_err 'listen_port' 1
check_psql_connect "${PSQL_LOCALIP}" || exit_err 'psql_connect: Connect failure' 1
exit 0