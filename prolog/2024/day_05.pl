#!/usr/bin/env swipl

:- initialization(main, main).

valid([]).
valid([_]).
valid([FirstPage | Pages]) :-
    maplist([LaterPage] >> (\+ before(LaterPage, FirstPage)), Pages),
    valid(Pages).

middle_elem(List, Middle) :-
    append(Front, [Middle | Back], List),
    length(Front, Length),
    length(Back, Length).

part_1(Updates, Result) :-
    include(valid, Updates, ValidUpdates),
    maplist(middle_elem, ValidUpdates, Middles),
    sumlist(Middles, Result).

halve_list(List, Front, Back) :-
    length(List, Length),
    mod(Length, 2) =:= 0,
    append(Front, Back, List),
    length(Front, HalfLength),
    length(Back, HalfLength).

halve_list(List, Front, Back) :-
    length(List, Length),
    mod(Length, 2) =:= 1,
    append(Front, Back, List),
    length(Front, ShortHalfLength),
    length(Back, LongHalfLength),
    succ(ShortHalfLength, LongHalfLength).

reorder([], []).
reorder([Page], [Page]).
reorder(ValidUpdate, ValidUpdate) :-
    valid(ValidUpdate).
reorder(InvalidUpdate, ValidUpdate) :-
    \+ valid(InvalidUpdate),
    halve_list(InvalidUpdate, Front, Back),
    reorder(Front, ValidFront),
    reorder(Back, ValidBack),
    merge_update(ValidFront, ValidBack, ValidUpdate).

merge_update([], [], []).
merge_update([], Result, Result).
merge_update(Result, [], Result).
merge_update([X | Rest1], [Y | Rest2],  Result) :-
    valid([X, Y]),
    merge_update(Rest1, [Y | Rest2], ResultRest),
    Result = [X | ResultRest];
    merge_update([X | Rest1], Rest2, ResultRest),
    Result = [Y | ResultRest].

part_2(Updates, Result) :-
    exclude(valid, Updates, InvalidUpdates),
    maplist(reorder, InvalidUpdates, ValidUpdates),
    maplist(middle_elem, ValidUpdates, Middles),
    sumlist(Middles, Result).


read_rule(Line) :-
    sub_string(Line, _, 1, _, "|"),
    split_string(Line, "|", "", [BeforeStr, AfterStr]),
    number_string(Before, BeforeStr),
    number_string(After, AfterStr),
    assert(before(Before, After)).

read_update(Line, Update) :-
    sub_string(Line, _, 1, _, ","),
    split_string(Line, ",", "", UpdateStrs),
    maplist(number_string, Update, UpdateStrs).

read_data(Stream, []) :-
    at_end_of_stream(Stream).

read_data(Stream, Updates) :-
    read_line_to_string(Stream, Line),
    (
        read_rule(Line),
        read_data(Stream, Updates);

        read_update(Line, Update),
        [Update | MoreUpdates] = Updates,
        read_data(Stream, MoreUpdates);

        read_data(Stream, Updates)
    ).

main :-
    read_data(user_input, Updates),
    part_1(Updates, Result1),
    write(Result1), nl,
    part_2(Updates, Result2),
    write(Result2), nl.
