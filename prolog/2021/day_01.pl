#!/usr/bin/env swipl

:- initialization(main, main).

read_data(Stream, []) :- 
    at_end_of_stream(Stream).

read_data(Stream, [X|Xs]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_codes(Stream, Codes),
    read_from_chars(Codes, X),
    read_data(Stream, Xs).




part_1([X1, X2 | []], Count, FinalCount) :-
    X1 < X2,
    succ(Count, FinalCount).

part_1([X1, X2 | []], Count, FinalCount) :-
    X1 >= X2,
    Count = FinalCount.

part_1([X1, X2 | Xs], Count, FinalCount) :-
    X1 < X2,
    succ(Count, CountNext),
    part_1([X2 | Xs], CountNext, FinalCount).

part_1([X1, X2 | Xs], Count, FinalCount) :-
    X1 >= X2, 
    part_1([X2 | Xs], Count, FinalCount).


take(N, List, Prefix) :-
    N = 0,
    Prefix = [].
take(N, List, Prefix) :-
    List = [],
    \+ (N > 0).
take(N, [X | Xs], [PrefixHead | PrefixTail]) :-
    N > 0,
    succ(DecN, N),
    X = PrefixHead,
    take(DecN, Xs, PrefixTail).

drop(N, List, Suffix) :-
    N = 0,
    List = Suffix.
drop(N, List, Suffix) :-
    List = [],
    \+ (N > 0).
drop(N, [X | Xs], Suffix) :-
    N > 0,
    succ(DecN, N),
    drop(DecN, Xs, Suffix).

window(Size, Step, List, Windowed) :-
    List = [],
    Windowed = [].
window(Size, Step, List, [Window | WindowedTail]) :-
    dif(List, []),
    take(Size, List, Window),
    drop(Step, List, NextList),
    window(Size, Step, NextList, WindowedTail).
window(Size, Step, List, Windowed) :-
    dif(List, []),
    \+ take(Size, List, Window),
    window(Size, Step, [], Windowed).

sum(List, N) :-
    foldl(plus, List, 0, N).

part_2(Readings, Count) :-
    window(3, 1, Readings, Windowed),
    maplist(sum, Windowed, Summed),
    part_1(Summed, 0, Count).







main(Argv) :-
    read_data(user_input, SonarReadings),
    part_1(SonarReadings, 0, Count1),
    write(Count1), nl,
    part_2(SonarReadings, Count2),
    write(Count2), nl.
