-module(day03_2).
-mode(compile).

-export([main/1]).

main(_) ->
    Input = read_mat(),
    OxyGenRate = most_common(Input),
    CoRate = least_common(Input),
    io:format("~p * ~p = ~p~n", [OxyGenRate, CoRate, OxyGenRate * CoRate]).

read_mat() ->
    lists:reverse(read_mat([])).

read_mat(Acc) ->
    case io:fread("", "~s") of
        {ok, [Line]} -> read_mat([Line | Acc]);
        eof -> to_int_mat(Acc)
    end.

most_common(M) -> bits_to_int(most_common(M, 1)).
most_common([X], _) -> X;
most_common(M, S) ->
    Bit = lists:nth(S, count_common(M)),
    Matched = [X || X <- M, lists:nth(S, X) =:= Bit],
    most_common(Matched, S + 1).

least_common(M) -> bits_to_int(least_common(M, 1)).
least_common([X], _) -> X;
least_common(M, S) ->
    Bit = lists:nth(S, count_common(M)),
    Matched = [X || X <- M, lists:nth(S, X) =/= Bit],
    least_common(Matched, S + 1).

count_common(M) ->
    Len = length(M) ,
    Half = Len div 2,
    [(lists:sum(X) + Half) div Len || X <- utils:transpose(M)].

to_int_mat([X | M]) -> [[C - $0 || C <- X] | to_int_mat(M)];
to_int_mat([]) -> [].

bits_to_int(BitList) ->
    Len = length(BitList),
    <<I:Len>> = << <<B:1>> || B <- BitList>>,
    I.
