empty_string("").

stream_lines(In, Lines) :-
    read_string(In, _, Str),
    split_string(Str, "\n", "", RawLines),
    exclude(empty_string, RawLines, Lines).

take(N, List, Prefix) :-
    prefix(Prefix, List),
    length(Prefix, N).

drop(N, List, Suffix) :-
    append(_, Suffix, List),
    length(List, OriginalLength),
    NewLength is OriginalLength - N,
    length(Suffix, NewLength).

window(_, _, [], []).
window(Size, Step, List, [Window | WindowedTail]) :-
    dif(List, []),
    take(Size, List, Window),
    drop(Step, List, NextList),
    window(Size, Step, NextList, WindowedTail).
window(Size, Step, List, Windowed) :-
    dif(List, []),
    \+ take(Size, List, _),
    window(Size, Step, [], Windowed).
