#!/usr/bin/env -S awk -f

/forward/ { horizontal += $2 }
/down/    { depth += $2 }
/up/      { depth -= $2 }
END       { print(horizontal * depth) }
