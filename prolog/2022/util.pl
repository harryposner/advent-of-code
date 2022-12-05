empty_string("").

stream_lines(In, Lines) :-
    read_string(In, _, Str),
    split_string(Str, "\n", "", RawLines),
    exclude(empty_string, RawLines, Lines).
