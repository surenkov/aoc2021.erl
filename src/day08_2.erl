-module(day08_2).
-mode(compile).

-export([main/1]).

main(_) ->
    Lines = read_input(),
    Digits = [count_digits(L) || L <- Lines],
    io:format("~p~n", [length(perms("abcdefg"))]).
    % io:format("~p~n", [Digits]).

read_input()    -> read_input([]).
read_input(Acc) ->
    case io:get_line("") of
        eof  -> lists:reverse(Acc);
        Line -> read_input([parse_line(Line) | Acc])
    end.

perms([]) -> [[]];
perms(S)  -> [[H|T] || H <- S, T <- perms(S--[H])].

parse_line(Line) ->
    [RS, RD] = string:split(lists:droplast(Line), " | "),
    S = [ordsets:from_list(N) || N <- string:split(RS, " ", all)],
    D = [ordsets:from_list(N) || N <- string:split(RD, " ", all)],
    {S, D}.

count_digits({Signals, Digits}) ->
    Segments = infer_segments(Signals),
    [(decode_digit(D, Segments)) || D <- Digits].

infer_segments(Segments) -> infer_segments(Segments, [], []).

infer_segments(S, [], K) -> K;
infer_segments(S, N, K) -> ok.

decode_digit(D, Sq) -> ok.
