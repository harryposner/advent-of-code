#!/usr/bin/env -S gawk -f

{
	increasing = 0;
	unsafe = 0;
	if ($1 < $2) {
		increasing = 1;
	}
	for (i = 1; i < NF; i++) {
		j = i + 1;
		unsafe = increasing && $i >= $j ||
		       !increasing && $i <= $j ||
		       increasing && $j - $i > 3 ||
		       !increasing && $i - $j > 3;
		if (unsafe) {
			break;
		}
	}
	n_safe += !unsafe;
}

END {
	print n_safe;
}
