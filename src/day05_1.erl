-module(day05_1).

-mode(compile).

-export([main/1]).

main(_) ->
    Lines = read_lines(),
    Points = to_points(Lines),
    io:format("~p~n", [unique_common(Points)]).

to_points(Lines) ->
    lists:sort([P || {P1, P2} <- Lines, P <- line_to_points(P1, P2)]).

unique_common([]) -> 0;
unique_common([H|T]) -> unique_common(T, H, 0, 0).

unique_common([], _, _, Acc) -> Acc;
unique_common([H|T], H, 0, Acc) -> unique_common(T, H, 1, Acc + 1);
unique_common([H|T], H, N, Acc) -> unique_common(T, H, N + 1, Acc);
unique_common([H|T], _, _, Acc) -> unique_common(T, H, 0, Acc).


line_to_points(P, P) -> [P];
line_to_points(P1 = {X, Y}, P2 = {X2, Y2}) ->
    XS = (X2 - X) div max(abs(X2 - X), 1),
    YS = (Y2 - Y) div max(abs(Y2 - Y), 1),
    line_to_points(P1, P2, XS, YS).
line_to_points(P, P, _, _) -> [P];
line_to_points({X, Y}, {X2, Y2}, XS, YS) ->
    [{X, Y} | line_to_points({X + XS, Y + YS}, {X2, Y2})].

read_lines() -> filter_axis(read_lines([]), []).
read_lines(Acc) ->
    case io:fread("", "~d,~d -> ~d,~d") of
        {ok, [X1, Y1, X2, Y2]} ->
            read_lines([{{X1, Y1}, {X2, Y2}} | Acc]);
        eof -> Acc
    end.

filter_axis([], Acc) -> Acc;
filter_axis([Line = {{X, _}, {X, _}} | Rest], Acc) -> filter_axis(Rest, [Line | Acc]);
filter_axis([Line = {{_, Y}, {_, Y}} | Rest], Acc) -> filter_axis(Rest, [Line | Acc]);
filter_axis([_ | Rest], Acc) -> filter_axis(Rest, Acc).
