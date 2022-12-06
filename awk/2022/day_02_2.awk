#!/usr/bin/env -S awk -f

/Y/   { score += 3 }
/Z/   { score += 6 }
/A X/ { score += 3 }
/A Y/ { score += 1 }
/A Z/ { score += 2 }
/B X/ { score += 1 }
/B Y/ { score += 2 }
/B Z/ { score += 3 }
/C X/ { score += 2 }
/C Y/ { score += 3 }
/C Z/ { score += 1 }
END   { print(score) }
