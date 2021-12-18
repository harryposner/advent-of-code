#!/bin/bash

set -euo pipefail

sed 's/.*| //g' <&0 \
| sed 's/ /\n/g' \
| awk '
	/^[a-g]{2,4}$/ { acc++ }
	/^[a-g]{7}$/   { acc++ }
	END            { print(acc++) }'
