#!/usr/bin/env swipl

:- initialization(main, main).

increasing([]).
increasing([_]).
increasing([First, Second | Tail]) :-
    First < Second,
    increasing([Second | Tail]).

decreasing(List) :-
    reverse(List, ReversedList),
    increasing(ReversedList).

deltas_one_to_three([]).
deltas_one_to_three([_]).
deltas_one_to_three([First, Second | Tail]) :-
    Delta is abs(First - Second),
    Delta >= 1,
    Delta =< 3,
    deltas_one_to_three([Second | Tail]).

safe_part_1(Levels) :-
    increasing(Levels), deltas_one_to_three(Levels);
    decreasing(Levels), deltas_one_to_three(Levels).

part_1(Lines, Result) :-
    include(safe_part_1, Lines, SafeLines),
    length(SafeLines, Result).

remove_one(List, LessOne) :-
    append(Front, [_ | Back], List),
    append(Front, Back, LessOne).

safe_part_2(Levels) :-
    remove_one(Levels, LessOne),
    safe_part_1(LessOne).

part_2(Lines, Result) :-
    include(safe_part_2, Lines, SafeLines),
    length(SafeLines, Result).

read_data(Stream, []) :-
    at_end_of_stream(Stream).

read_data(Stream, [X | Xs]) :-
    read_line_to_string(Stream, Line),
    split_string(Line, " ", "", NumberStrings),
    maplist(number_string, X, NumberStrings),
    read_data(Stream, Xs).

main :-
    read_data(user_input, AllLevels),
    part_1(AllLevels, Result1),
    write(Result1), nl,
    part_2(AllLevels, Result2),
    write(Result2), nl.
