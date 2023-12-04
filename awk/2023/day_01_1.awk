#!/usr/bin/env -S gawk -f

{ val = 0 }
match($0, /[a-z]*([0-9])/, grps) {
	val += grps[1] * 10;
}
match($0, /[a-z0-9]*([0-9])/, grps) {
	val += grps[1];
}
{ ans += val }

END { print(ans) }
