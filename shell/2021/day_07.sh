#!/bin/bash

set -euo pipefail


POSITIONS=$(sed 's/,/\n/g' <&0)

cost_part_1 () {
	awk -v pos=$1 '
		{ diff = $1 - pos; cost += (diff < 0) ? -diff  : diff }
		END { print(cost) }' <<< "$POSITIONS"
}

cost_part_2 () {
	awk -v pos=$1 '
		{
			diff = ($1 < pos) ? pos - $1 : $1 - pos;
			cost += diff * (diff + 1) / 2;
		}
		END { print(cost) }' <<< "$POSITIONS"
}

find_best_position () {

	BEST_SO_FAR=$($1 0)
	for i in $(seq 1 $(sort -n <<< "$POSITIONS" | tail -n 1))
	do
		CURRENT_COST=$($1 $i)
		if [ $CURRENT_COST -lt $BEST_SO_FAR ]
		then
			BEST_SO_FAR=$CURRENT_COST
		fi
	done

	printf "$BEST_SO_FAR\n"

}

find_best_position 'cost_part_1'
find_best_position 'cost_part_2'
