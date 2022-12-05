string_move("A", rock).
string_move("B", paper).
string_move("C", scissors).
string_move("X", rock).
string_move("Y", paper).
string_move("Z", scissors).


strategy_score(Them, Me, Score) :-
    outcome_score(Them, Me, OS),
    shape_score(Me, SS),
    Score is OS + SS.


outcome_score(Them, Me, 3) :-
    Them = Me.

outcome_score(Them, Me, 0) :-
    outcome_score(Me, Them, 6).

outcome_score(rock, paper, 6).
outcome_score(paper, scissors, 6).
outcome_score(scissors, rock, 6).

shape_score(rock, 1).
shape_score(paper, 2).
shape_score(scissors, 3).


part_1(TheirMoves, MyMoves, TotalScore) :-
    maplist(strategy_score, TheirMoves, MyMoves, StrategyScores),
    foldl(plus, StrategyScores, 0, TotalScore).
