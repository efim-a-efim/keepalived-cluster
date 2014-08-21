#!/usr/bin/env bash

# Check if directory $1 is RW
# Creates file, 

FS="${1:-/tmp}"

f=`mktemp --tmpdir="${FS}"`
[[ $? -gt 0 ]] && exit $?

d=`date -R`
echo -n "${d}" > "${f}" 2>&1
[[ $? -gt 0 ]] && exit $?

d_check=`cat "${f}"`
if [[ $? -gt 0 ]] || [[ "${d_check}" != "${d}" ]]; then
	exit $?
fi

rm "${f}"
[[ $? -gt 0 ]] && exit $?

exit 0