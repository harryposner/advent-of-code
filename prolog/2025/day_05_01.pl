#!/usr/bin/env swipl

:- initialization(main, main).


part_1(Result) :-
    setof(X, (ingredient(X), fresh(X)), AllFresh),
    length(AllFresh, Result).

read_data(Stream) :-
    at_end_of_stream(Stream).

read_data(Stream) :-
    read_line_to_string(Stream, Line),
    read_data_line(Line),
    read_data(Stream).

read_data_line(Line) :-
    sub_string(Line, _, _, _, "-"),
    split_string(Line, "-", "", NumberStrings),
    maplist(number_string, [StartId, EndId], NumberStrings),
    assertz((fresh(X) :- between(StartId, EndId, X))).

read_data_line("").

read_data_line(Line) :-
    number_string(Ingredient, Line),
    assertz(ingredient(Ingredient)).


main :-
    read_data(user_input),
    part_1(Result1),
    write(Result1), nl.
