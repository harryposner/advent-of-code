#!/usr/bin/env swipl

:- initialization(main, main).

:- [day_02_common, util].


line_strategy_1(Line, TheirMove, MyMove) :-
    split_string(Line, " ", "", [TheirMoveStr, MyMoveStr]),
    string_move(TheirMoveStr, TheirMove),
    string_move(MyMoveStr, MyMove).

main :-
    stream_lines(user_input, Lines),
    maplist(line_strategy_1, Lines, TheirMoves, MyMoves),
    part_1(TheirMoves, MyMoves, TotalScore),
    write(TotalScore), nl.
