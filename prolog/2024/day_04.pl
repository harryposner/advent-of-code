#!/usr/bin/env swipl

:- initialization(main, main).


xmas(R1, C1, R2, C2, R3, C3, R4, C4) :-
    word_map('X', R1, C1),
    horizontal(R1, C1, R2, C2, R3, C3, R4, C4),
    word_map('M', R2, C2),
    word_map('A', R3, C3),
    word_map('S', R4, C4).

xmas(R1, C1, R2, C2, R3, C3, R4, C4) :-
    word_map('X', R1, C1),
    horizontal_backwards(R1, C1, R2, C2, R3, C3, R4, C4),
    word_map('M', R2, C2),
    word_map('A', R3, C3),
    word_map('S', R4, C4).

xmas(R1, C1, R2, C2, R3, C3, R4, C4) :-
    word_map('X', R1, C1),
    vertical(R1, C1, R2, C2, R3, C3, R4, C4),
    word_map('M', R2, C2),
    word_map('A', R3, C3),
    word_map('S', R4, C4).

xmas(R1, C1, R2, C2, R3, C3, R4, C4) :-
    word_map('X', R1, C1),
    vertical_backwards(R1, C1, R2, C2, R3, C3, R4, C4),
    word_map('M', R2, C2),
    word_map('A', R3, C3),
    word_map('S', R4, C4).

xmas(R1, C1, R2, C2, R3, C3, R4, C4) :-
    word_map('X', R1, C1),
    diagonal_nw_se(R1, C1, R2, C2, R3, C3, R4, C4),
    word_map('M', R2, C2),
    word_map('A', R3, C3),
    word_map('S', R4, C4).

xmas(R1, C1, R2, C2, R3, C3, R4, C4) :-
    word_map('X', R1, C1),
    diagonal_se_nw(R1, C1, R2, C2, R3, C3, R4, C4),
    word_map('M', R2, C2),
    word_map('A', R3, C3),
    word_map('S', R4, C4).

xmas(R1, C1, R2, C2, R3, C3, R4, C4) :-
    word_map('X', R1, C1),
    diagonal_ne_sw(R1, C1, R2, C2, R3, C3, R4, C4),
    word_map('M', R2, C2),
    word_map('A', R3, C3),
    word_map('S', R4, C4).

xmas(R1, C1, R2, C2, R3, C3, R4, C4) :-
    word_map('X', R1, C1),
    diagonal_sw_ne(R1, C1, R2, C2, R3, C3, R4, C4),
    word_map('M', R2, C2),
    word_map('A', R3, C3),
    word_map('S', R4, C4).


horizontal(Row, C1, Row, C2, Row, C3, Row, C4) :-
    max_col(MaxCol),
    between(0, MaxCol, C1),
    succ(C1, C2),
    succ(C2, C3),
    succ(C3, C4),
    between(0, MaxCol, C4).
 
horizontal_backwards(Row, C1, Row, C2, Row, C3, Row, C4) :-
    max_col(MaxCol),
    between(0, MaxCol, C1),
    succ(C2, C1),
    succ(C3, C2),
    succ(C4, C3),
    between(0, MaxCol, C4).

vertical(R1, Col, R2, Col, R3, Col, R4, Col) :-
    max_row(MaxRow),
    between(0, MaxRow, R1),
    succ(R1, R2),
    succ(R2, R3),
    succ(R3, R4),
    between(0, MaxRow, R4).

vertical_backwards(R1, Col, R2, Col, R3, Col, R4, Col) :-
    max_row(MaxRow),
    between(0, MaxRow, R1),
    succ(R2, R1),
    succ(R3, R2),
    succ(R4, R3),
    between(0, MaxRow, R4).

diagonal_nw_se(R1, C1, R2, C2, R3, C3, R4, C4) :-
    max_row(MaxRow),
    between(0, MaxRow, R1),
    max_col(MaxCol),
    between(0, MaxCol, C1),
    succ(R1, R2),
    succ(R2, R3),
    succ(R3, R4),
    succ(C1, C2),
    succ(C2, C3),
    succ(C3, C4),
    between(0, MaxRow, R4),
    between(0, MaxCol, C4).

diagonal_se_nw(R1, C1, R2, C2, R3, C3, R4, C4) :-
    max_row(MaxRow),
    between(0, MaxRow, R1),
    max_col(MaxCol),
    between(0, MaxCol, C1),
    succ(R2, R1),
    succ(R3, R2),
    succ(R4, R3),
    succ(C2, C1),
    succ(C3, C2),
    succ(C4, C3),
    between(0, MaxRow, R4),
    between(0, MaxCol, C4).

diagonal_ne_sw(R1, C1, R2, C2, R3, C3, R4, C4) :-
    max_row(MaxRow),
    between(0, MaxRow, R1),
    max_col(MaxCol),
    between(0, MaxCol, C1),
    succ(R1, R2),
    succ(R2, R3),
    succ(R3, R4),
    succ(C2, C1),
    succ(C3, C2),
    succ(C4, C3),
    between(0, MaxRow, R4),
    between(0, MaxCol, C4).

diagonal_sw_ne(R1, C1, R2, C2, R3, C3, R4, C4) :-
    max_row(MaxRow),
    between(0, MaxRow, R1),
    max_col(MaxCol),
    between(0, MaxCol, C1),
    succ(R2, R1),
    succ(R3, R2),
    succ(R4, R3),
    succ(C1, C2),
    succ(C2, C3),
    succ(C3, C4),
    between(0, MaxRow, R4),
    between(0, MaxCol, C4).

xmas_2(R1, C1) :-
    max_row(MaxRow),
    between(0, MaxRow, R1),
    max_col(MaxCol),
    between(0, MaxCol, C1),
    succ(R1, R2),
    succ(R2, R3),
    succ(C1, C2),
    succ(C2, C3),
    word_map('A', R2, C2),
    (
        word_map('M', R1, C1),
        word_map('S', R3, C3);
        word_map('S', R1, C1),
        word_map('M', R3, C3)
    ),
    (
        word_map('M', R1, C3),
        word_map('S', R3, C1);
        word_map('S', R1, C3),
        word_map('M', R3, C1)
    ).


part_1(Result) :-
    setof((R1, C1, R2, C2, R3, C3, R4, C4), xmas(R1, C1, R2, C2, R3, C3, R4, C4), Solutions),
    length(Solutions, Result).

part_2(Result) :-
    setof((R1, C1), xmas_2(R1, C1), Solutions),
    length(Solutions, Result).

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

        succ(Col, ColNext),
        assert(word_map(Char, Row, Col)),
        read_data(Stream, Row, ColNext)
    ).

main :-
    read_data(user_input, 0, 0),
    part_1(Result1),
    write(Result1), nl,
    part_2(Result2),
    write(Result2), nl.
