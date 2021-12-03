#!/usr/bin/env -S awk -f

{
	if(NR != 1 && $1 > prev)
		acc++;
	prev = $1;
}

END { printf(acc) }
