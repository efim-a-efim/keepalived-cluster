#!/bin/bash

declare -a _files

read -d '' _data <<EOD
Heal operation on volume testvol has been successful

Brick server1:/data/testvol/brick1
Number of entries: 1
at                   path on brick
----------------------------------
2012-06-13 04:02:05  /foo/bar

Brick server2:/data/testvol/brick1
Number of entries: 1
at                   path on brick
----------------------------------
2012-06-13 04:02:05  /foo/bar
EOD

echo "${_data}" | \
while read _line; do
echo "${_line}"
case "_${_line}" in
    _Brick*|"")
	_brick=`echo "${_line}" | tr -s ' ' | cut -d ' ' -f 2`
    ;;
    _????-??-??\ ??:??:??*)
	_file=`echo "${_line}" | tr -s ' ' | cut -d ' ' -f 3-`
	echo gluster_heal_file "${_brick}" "${_file}"
    ;;
    _)
	_file=`echo "${_line}" | tr -s ' ' | cut -d ' ' -f 3-`
	echo gluster_heal_file "${_brick}" "${_file}"
    ;;
esac
done