#!/usr/bin/env bash

set -euo pipefail

INPUT=$(cat)

readarray -t left  < <(sed 's/\s\+/:/g' <<< "$INPUT" | cut -d ':' -f 1 | sort)
readarray -t right < <(sed 's/\s\+/:/g' <<< "$INPUT" | cut -d ':' -f 2 | sort)

total=0
for i in "${!left[@]}"
do
	diff=$((left[i]-right[i]))
	if ([ $diff -lt 0 ])
	then
		diff=$((-diff))
	fi
	total=$((total + diff))
done

printf $total
