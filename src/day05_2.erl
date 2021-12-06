-module(day05_2).

-mode(compile).

-export([main/1]).

main(_) ->
    Lines = read_lines(),
    Points = common_points(Lines),
    io:format("~p~n", [unique_count(Points)]).

common_points(Lines) ->
    [P|Points] = lists:sort([P || {P1, P2} <- Lines, P <- line_to_points(P1, P2)]),
    common_points(Points, P, []).

common_points([], _, Acc) -> Acc;
common_points([H|T], H, Acc) -> common_points(T, H, [H|Acc]);
common_points([H|T], _, Acc) -> common_points(T, H, Acc).


unique_count([]) -> 0;
unique_count([H|T]) -> unique_count(T, H, 1).

unique_count([], _, Acc) -> Acc;
unique_count([H|T], H, Acc) -> unique_count(T, H, Acc);
unique_count([H|T], _, Acc) -> unique_count(T, H, Acc + 1).


line_to_points(P, P) -> [P];
line_to_points(P1 = {X, Y}, P2 = {X2, Y2}) ->
    XS = (X2 - X) div max(abs(X2 - X), 1),
    YS = (Y2 - Y) div max(abs(Y2 - Y), 1),
    line_to_points(P1, P2, XS, YS).
line_to_points(P, P, _, _) -> [P];
line_to_points({X, Y}, {X2, Y2}, XS, YS) ->
    [{X, Y} | line_to_points({X + XS, Y + YS}, {X2, Y2})].

read_lines() -> read_lines([]).
read_lines(Acc) ->
    case io:fread("", "~d,~d -> ~d,~d") of
        {ok, [X1, Y1, X2, Y2]} ->
            read_lines([{{X1, Y1}, {X2, Y2}} | Acc]);
        eof -> Acc
    end.
