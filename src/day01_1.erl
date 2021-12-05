-module(day01_1).

-export([main/1]).

main(_) ->
    SigList = read_input(),
    Result = process_signals(SigList),
    io:format("~w~n", [Result]).


read_input() -> lists:reverse(read_input([])).
read_input(Acc) ->
    case io:fread("", "~d") of
        {ok, [Int]} -> read_input([Int | Acc]);
        eof         -> Acc
    end.


process_signals(SigList = [_ | _]) -> process_signals(0, SigList);
process_signals(_) -> 0.

process_signals(Acc, [H, Next | Rest]) when Next > H -> process_signals(Acc + 1, [Next | Rest]);
process_signals(Acc, [H, Next | Rest]) when Next =< H -> process_signals(Acc, [Next | Rest]);
process_signals(Acc, [_Last]) -> Acc;
process_signals(_, []) -> 0.
