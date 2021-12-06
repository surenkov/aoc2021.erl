-module(day06).
-mode(compile).

-export([main/1]).

main([Num]) ->
    Generations = read_input(),
    Population = evolve(Generations, list_to_integer(Num)),
    Totals = count_population(Population),
    io:format("~p~n", [Totals]).

evolve(Generations, 0)   -> Generations;
evolve(Generations, Day) -> evolve(Day, Generations, []).

evolve(0, Gen, _)             -> Gen;
evolve(Day, [], Next)         -> evolve(Day-1, compact(Next), []);
evolve(Day, [Gen|Rest], Next) ->
    case Gen of
        {0, C} -> evolve(Day, Rest, [{6, C}, {8, C} | Next]);
        {N, C} -> evolve(Day, Rest, [{N-1, C} | Next])
    end.

compact(Gen) ->
    [H|Rest] = lists:keysort(1, Gen),
    compact(Rest, [H]).

compact([], Acc)                        -> Acc;
compact([{H, C1} | T], [{H, C2} | Acc]) -> compact(T, [{H, C1+C2} | Acc]);
compact([H | T], Acc)                   -> compact(T, [H | Acc]).

count_population(Gen) ->
    lists:sum([C || {_, C} <- Gen]).

read_input() ->
    SeqLine = lists:droplast(io:get_line("")),
    SplitArgs = string:split(SeqLine, ",", all),
    Generations = lists:map(fun list_to_integer/1, SplitArgs),
    count_ages(lists:sort(Generations)).

count_ages([H|T]) -> count_ages(T, [{H, 1}]).

count_ages([], Acc)               -> lists:reverse(Acc);
count_ages([H|T], [{H, N} | Acc]) -> count_ages(T, [{H, N+1} | Acc]);
count_ages([H|T], Acc)            -> count_ages(T, [{H, 1} | Acc]).
