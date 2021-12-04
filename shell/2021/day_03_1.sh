#!/bin/bash

set -euo pipefail

GAMMA=$(sed 's/\([01]\)/\1\ /g' <&0 \
	| awk '
	{
		for (i = 1; i <= NF; i++) {
			n_ones_in_place[i] += $i
		}
	}
	END {
		for (i = 1; i <= NF; i++) {
			if (n_ones_in_place[i] > NR / 2)
				printf("1");
			else
				printf("0");
		}
	}'
)

EPSILON=$(tr 01 10 <<< $GAMMA)

printf "$((2#$GAMMA * 2#$EPSILON))\n"
