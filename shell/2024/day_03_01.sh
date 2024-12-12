#!/usr/bin/env bash

set -euo pipefail

grep -Eo 'mul\([0-9]+,[0-9]+\)' <&0 \
	| sed 's/[^0-9]/ /g' \
	| awk '{ acc += $1 * $2 } END { print acc }'
