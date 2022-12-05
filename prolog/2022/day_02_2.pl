#!/usr/bin/env swipl

:- initialization(main, main).

:- [day_02_common, util].


string_target_score("X", 0).
string_target_score("Y", 3).
string_target_score("Z", 6).

line_strategy_2(Line, TheirMove, MyMove) :-
    split_string(Line, " ", "", [TheirMoveStr, TargetScoreStr]),
    string_move(TheirMoveStr, TheirMove),
    string_target_score(TargetScoreStr, TargetScore),
    outcome_score(TheirMove, MyMove, TargetScore).

main :-
    stream_lines(user_input, Lines),
    maplist(line_strategy_2, Lines, TheirMoves, MyMoves),
    part_1(TheirMoves, MyMoves, TotalScore),
    write(TotalScore), nl.
