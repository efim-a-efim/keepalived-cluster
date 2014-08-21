#!/usr/bin/env bash

[[ -f "${1:-./check-sys-parameters.conf}" ]] && \
	. "${1:-./check-sys-parameters.conf}"

exit 0