#!/usr/bin/env swipl

:- initialization(main, main).


valid_step(R1, C1, R2, C2, H2) :-
    (
        succ(R2, R1), C1 = C2;  % N
        R1 = R2, succ(C1, C2);  % E
        succ(R1, R2), C1 = C2;  % S
        R1 = R2, succ(C2, C1)   % W
    ),
    topo_map(H1, R1, C1),
    topo_map(H2, R2, C2),
    succ(H1, H2).

trail(R, C, 9, R, C) :-
    topo_map(9, R, C).
trail(R, C, H, FinalR, FinalC) :-
    topo_map(H, R, C),
    valid_step(R, C, RNext, CNext, HNext),
    trail(RNext, CNext, HNext, FinalR, FinalC).

trailhead_score(Score) :-
    setof((FinalR, FinalC), trail(_, _, 0, FinalR, FinalC), Destinations),
    length(Destinations, Score).

part_1(Result) :-
    findall(Score, trailhead_score(Score), Scores),
    sumlist(Scores, Result).

trailhead_rating(Rating) :-
    aggregate_all(count, trail(_, _, 0, _, _), Rating).

part_2(Result) :-
    findall(Rating, trailhead_rating(Rating), Ratings),
    sumlist(Ratings, Result).


read_data(Stream, Row, _) :-
    at_end_of_stream(Stream),
    succ(MaxRow, Row),
    assert(max_row(MaxRow)).

read_data(Stream, Row, Col) :-
    get_char(Stream, Char),
    (
        Char = '\n',
        succ(Row, RowNext),
        ColNext = 0,
        succ(MaxCol, Col),
        assert(max_col(MaxCol)),
        read_data(Stream, RowNext, ColNext);

        \+ Char = end_of_file,
        \+ Char = '\n',
        succ(Col, ColNext),
        number_chars(Height, [Char]),
        assert(topo_map(Height, Row, Col)),
        read_data(Stream, Row, ColNext)
    ).

main :-
    % open("day_10_example.txt", read, Input),
    read_data(user_input, 0, 0),
    part_1(Result1),
    write(Result1), nl,
    part_2(Result2),
    write(Result2), nl.
