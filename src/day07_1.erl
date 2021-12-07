-module(day07_1).

-mode(compile).

-export([main/1]).

main(_) ->
    Pos = utils:read_int_line(),
    M = lists:nth(length(Pos) div 2, lists:sort(Pos)),
    FuelSpent = lists:sum([abs(X - M) || X <- Pos]),
    io:format("~p~n", [FuelSpent]).
