-module(day08_1).
-mode(compile).

-export([main/1]).

main(_) ->
    Lines = read_input(),
    io:format("~p~n", [count_digits(Lines)]).

read_input()    -> read_input([]).
read_input(Acc) ->
    case io:get_line("") of
        eof  -> lists:reverse(Acc);
        Line -> read_input([parse_line(Line) | Acc])
    end.

parse_line(Line) ->
    [_, RawDigits] = string:split(lists:droplast(Line), " | "),
    string:split(RawDigits, " ", all).

count_digits(Lines) -> lists:sum([count_digits(L, 0) || L <- Lines]).

count_digits([], Acc) -> Acc;
count_digits([H|T], Acc) ->
    case length(H) of
        2 -> count_digits(T, Acc+1);
        4 -> count_digits(T, Acc+1);
        3 -> count_digits(T, Acc+1);
        7 -> count_digits(T, Acc+1);
        _ -> count_digits(T, Acc)
    end.
