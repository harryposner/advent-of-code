#!/bin/bash

set -euo pipefail


OXYGEN_RESULT=$(< /dev/stdin)
CO2_RESULT=$OXYGEN_RESULT

N_BITS=$(head -n 1 <<< "$OXYGEN_RESULT" \
	| tr -d '\n' \
	| wc -c)

most_common_bit_in_place () {
	cut -c $1-$1 <<< "$2" \
	| awk '
	/1/ { n_ones += 1 }
	END {
		if (n_ones >= NR / 2)
			printf("1");
		else
			printf("0");
	}'
}

DOTS=$(for j in $(seq 1 $N_BITS); do printf "." ; done)

for i in $(seq 0 $(($N_BITS - 1)))
do
	OXYGEN_BIT=$(most_common_bit_in_place $(($i + 1)) "$OXYGEN_RESULT")
	OXYGEN_PATTERN="${DOTS:0:i}$OXYGEN_BIT${DOTS:i+1:$N_BITS-i}"
	CO2_BIT=$(most_common_bit_in_place $(($i + 1)) "$CO2_RESULT" | tr 01 10)
	CO2_PATTERN="${DOTS:0:i}$CO2_BIT${DOTS:i+1:$N_BITS-i}"

	if [ $(wc -l <<< "$OXYGEN_RESULT") -gt 1 ]
	then
		OXYGEN_RESULT=$(grep "$OXYGEN_PATTERN" <<< "$OXYGEN_RESULT")
	fi

	if [ $(wc -l <<< "$CO2_RESULT") -gt 1 ]
	then
		CO2_RESULT=$(grep "$CO2_PATTERN" <<< "$CO2_RESULT")
	fi

done

printf "$((2#$OXYGEN_RESULT * 2#$CO2_RESULT))\n"
