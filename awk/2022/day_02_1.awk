#!/usr/bin/env -S awk -f

/X/   { score += 1 }
/Y/   { score += 2 }
/Z/   { score += 3 }
/A X/ { score += 3 }
/A Y/ { score += 6 }
/A Z/ { score += 0 }
/B X/ { score += 0 }
/B Y/ { score += 3 }
/B Z/ { score += 6 }
/C X/ { score += 6 }
/C Y/ { score += 0 }
/C Z/ { score += 3 }
END   { print(score) }
