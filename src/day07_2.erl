-module(day07_2).

-mode(compile).

-export([main/1]).

main(_) ->
    Pos = utils:read_int_line(),
    M   = lists:sum(Pos) div length(Pos),
    FuelSpent = lists:sum([cost(abs(X - M)) || X <- Pos]),
    io:format("~p~n", [FuelSpent]).

cost(D) -> D * (D+1) div 2.
