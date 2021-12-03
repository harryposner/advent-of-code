#!/usr/bin/env -S awk -f

{
	if(NR > 3 && $1 > p3)
		acc++;
	p3 = p2;
	p2 = p1;
	p1 = $1;
}

END { printf(acc); }
