#!/usr/bin/env swipl

:- initialization(main, main).

:- [util].


parse_line(Line, [Start1, End1, Start2, End2]) :-
    split_string(Line, ",", "", [Range1Str, Range2Str]),
    split_string(Range1Str, "-", "", [Start1Str, End1Str]),
    split_string(Range2Str, "-", "", [Start2Str, End2Str]),
    number_codes(Start1, Start1Str),
    number_codes(End1, End1Str),
    number_codes(Start2, Start2Str),
    number_codes(End2, End2Str).

one_range_contains_other([Start1, End1, Start2, End2]) :-
    Start1 =< Start2,
    End1 >= End2.
one_range_contains_other([Start1, End1, Start2, End2]) :-
    Start2 =< Start1,
    End2 >= End1.

part_1(Ranges, Count) :-
    include(one_range_contains_other, Ranges, Filtered),
    length(Filtered, Count).

ranges_overlap([Start1, End1, Start2, End2]) :-
    End1 >= Start2,
    Start1 =< End2.
ranges_overlap([Start1, End1, Start2, End2]) :-
    End2 >= Start1,
    Start2 =< End1.

part_2(Ranges, Count) :-
    include(ranges_overlap, Ranges, Filtered),
    length(Filtered, Count).


main :-
    stream_lines(user_input, LineStrings),
    maplist(parse_line, LineStrings, Ranges),
    part_1(Ranges, Count1),
    write(Count1), nl,
    part_2(Ranges, Count2),
    write(Count2), nl.
