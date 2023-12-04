#!/usr/bin/env -S awk -f

{
	delete winning_nums;
	winners_on_card = 0;
	for (i = 3; $i != "|"; i++) {
		winning_nums[$i] = 1;
	}
	for (i++; i <= NF; i++) {
		if (winning_nums[$i]) {
			winners_on_card++;
		}
	}
	if (winners_on_card)
		result += 2 ^ (winners_on_card - 1);
}

END { print(result); }
