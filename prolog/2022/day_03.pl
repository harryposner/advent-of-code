#!/usr/bin/env swipl

:- initialization(main, main).

:- [util].


halve_list(Whole, Half1, Half2) :-
    append(Half1, Half2, Whole),
    length(Half1, L),
    length(Half2, L).

code_score(CharCode, Score) :- 
    CharCode >=  97,  % a
    CharCode =< 122,  % z
    Score is CharCode - 96.

code_score(CharCode, Score) :-
    CharCode >= 65,  % A
    CharCode =< 90,  % Z
    Score is CharCode - 38.

line_code_scores(LineCharCodes, LineScores) :-
    maplist(code_score, LineCharCodes, LineScores).

exactly_one_common_element([FirstList | MoreLists], CommonElement) :-
    list_to_ord_set(FirstList, FirstSet),
    maplist(list_to_ord_set, MoreLists, MoreSets),
    foldl(ord_intersection, MoreSets, FirstSet, [CommonElement]).

part_1(Lines, Score) :-
    maplist(halve_list, Lines, Lefts, Rights),
    maplist([L, R, Out] >> ([L, R] = Out), Lefts, Rights, Halved),
    maplist(exactly_one_common_element, Halved, Scores),
    foldl(plus, Scores, 0, Score).

part_2(Lines, Score) :-
    window(3, 3, Lines, Groups),
    maplist(exactly_one_common_element, Groups, Scores),
    foldl(plus, Scores, 0, Score).

main :-
    stream_lines(user_input, LineStrings),
    maplist(string_codes, LineStrings, LineCodes),
    maplist(line_code_scores, LineCodes, Lines),
    part_1(Lines, Score1),
    write(Score1), nl,
    part_2(Lines, Score2),
    write(Score2), nl.
