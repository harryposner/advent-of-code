#!/usr/bin/env bash

set -euo pipefail

grep -Eo 'mul\([0-9]+,[0-9]+\)|do\(\)|don'\''t\(\)' <&0 \
	| sed 's/[(),]/ /g' \
	| awk '\
	BEGIN      { enabled = 1 } \
	/do/       { enabled = 1 } \
	/don'\''t/ { enabled = 0; } \
	/mul/      { acc += $2 * $3 * enabled } \
	END        { print acc }'
