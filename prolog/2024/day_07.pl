#!/usr/bin/env swipl

:- initialization(main, main).

% Part 1

evaluate(Num, [Num]).
evaluate(Result, [Num1, Num2 | Rest]) :-
    Sum is Num1 + Num2,
    evaluate(Result, [Sum | Rest]);
    Product is Num1 * Num2,
    evaluate(Result, [Product | Rest]).

solveable([Lhs | Rhs]) :-
    evaluate(Lhs, Rhs).

head([X | _], X).

part1(Equations, Result) :-
    include(solveable, Equations, SolvableEquations),
    maplist(head, SolvableEquations, TestVals),
    sumlist(TestVals, Result).


% Part 2

n_digits(Num, 1) :-
    Num >= 0,
    Num =< 9.

n_digits(Num, Digits) :-
    Num > 9,
    ShiftedRight is Num // 10,
    n_digits(ShiftedRight, OneFewerDigits),
    succ(OneFewerDigits, Digits).

concatenate(Num1, Num2, Result) :-
    n_digits(Num2, Digits),
    ShiftedLeft is Num1 * 10 ^ Digits,
    Result is ShiftedLeft + Num2.

evaluate2(Num, [Num]).
evaluate2(Result, [Num1, Num2 | Rest]) :-
    Sum is Num1 + Num2,
    evaluate2(Result, [Sum | Rest]);
    Product is Num1 * Num2,
    evaluate2(Result, [Product | Rest]);
    concatenate(Num1, Num2, Concatenated),
    evaluate2(Result, [Concatenated | Rest]).

solveable2([Lhs | Rhs]) :-
    evaluate2(Lhs, Rhs).

part2(Equations, Result) :-
    include(solveable2, Equations, SolvableEquations),
    maplist(head, SolvableEquations, TestVals),
    sumlist(TestVals, Result).


% Data munging

read_data(Stream, []) :-
    at_end_of_stream(Stream).

read_data(Stream, [X | Xs]) :-
    read_line_to_string(Stream, Line),
    split_string(Line, " ", ":", NumberStrings),
    maplist(number_string, X, NumberStrings),
    read_data(Stream, Xs).

main :-
    read_data(user_input, Equations),
    part1(Equations, Result1),
    write(Result1), nl,
    part2(Equations, Result2),
    write(Result2), nl.
