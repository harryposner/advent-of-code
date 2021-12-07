#!/bin/bash

set -euo pipefail


FISHES=$(sed 's/,/\n/g' <&0 \
	| awk '
	{ freqs[$1] += 1 }
	END { for(i=0; i<=8; i++) printf("%d\t%d\n", i, freqs[i]) }')

simulate_fish () {

	STATE="$FISHES"

	for i in $(seq 1 $1)
	do
		STATE=$(awk '
			/^[1-68]/ { printf("%d\t%d\n", ($1 - 1), $2) }
			/^0/      { n0 = $2; printf("8\t%d\n", $2) }
			/^7/      { n7 = $2; }
			END       { printf("6\t%d\n", n0 + n7) }
			' <<< "$STATE")
	done
	awk '{ sum += $2 } END { printf("%d\n", sum) }' <<< "$STATE"

}

simulate_fish 80
simulate_fish 256
