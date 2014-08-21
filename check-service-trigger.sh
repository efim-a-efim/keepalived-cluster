#!/bin/sh

[[ -f "${1:-./service.trigger}" ]] && exit 1
exit 0