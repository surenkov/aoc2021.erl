-module(day01_2).

-export([main/1]).

main(_) ->
    SigList = read_input(),
    Result  = sliding_signals(SigList),
    io:format("~w~n", [Result]).


read_input() -> lists:reverse(read_input([])).
read_input(Acc) ->
    case io:fread("", "~d") of
        {ok, [Int]} -> read_input([Int | Acc]);
        eof         -> Acc
    end.


sliding_signals(HeadList = [_ | MidList = [_ | RestList]]) ->
    sliding_signals(0, 0, HeadList, MidList, RestList);
sliding_signals(_) -> 0.

sliding_signals(Acc, _, _, _, []) -> Acc - 1;
sliding_signals(Acc, Prev, [H | HeadList], [M | MidList], [R | RestList]) ->
    Cur  = H + M + R,
    if Cur  > Prev -> sliding_signals(Acc + 1, Cur, HeadList, MidList, RestList);
       Cur =< Prev -> sliding_signals(Acc, Cur, HeadList, MidList, RestList)
    end.
