#!/bin/bash

set -euo pipefail

sed 's/.*| //g' <&0 \
| sed 's/ /\n/g' \
| awk '
	/^[a-g]{2}$/ { n1++ }
	/^[a-g]{4}$/ { n4++ }
	/^[a-g]{3}$/ { n7++ }
	/^[a-g]{7}$/ { n8++ }
	END          { print(n1 + n4 + n7 + n8) }'
