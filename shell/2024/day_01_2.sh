#!/usr/bin/env bash

set -euo pipefail

INPUT=$(cat)

touch /tmp/advent_of_code_2024_01_1

sed 's/\s\+/:/g' <<< "$INPUT" \
	| cut -d ':' -f 2 \
	| sort \
	| uniq -c \
	| sed -e 's/^/freq /g' \
	>> /tmp/advent_of_code_2024_01_1

sed 's/\s\+/:/g' <<< "$INPUT" \
	| cut -d ':' -f 1 \
	| sed -e 's/^/left /g' \
	>> /tmp/advent_of_code_2024_01_1

awk '\
	/^freq/ {printf("freq\t%d\t%d\n", $3, $2); freqs[$3] = $2 } \
	/^left/ {printf("left\t%d\t%d\n", $2, freqs[$2]); result += $2 * freqs[$2] } \
	END { print result }
	' < /tmp/advent_of_code_2024_01_1

rm /tmp/advent_of_code_2024_01_1
