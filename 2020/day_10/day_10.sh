echo 'Part 1:'
sort -g input.txt \
| awk '{if ($1 - prev == 1) n1 += 1; else n3 += 1} {prev = $1} END {print n1 * (n3 + 1)}'
