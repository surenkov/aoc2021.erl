-module(utils).

-mode(compile).

-import(lists, [reverse/1]).
-export([transpose/1, tail_transpose/1, read_int_line/0, read_int_line/1]).

transpose([[] | _]) -> [];
transpose(M) -> [[H || [H|_] <- M] | transpose([T || [_|T] <- M])].

tail_transpose([]) -> [];
tail_transpose(M) -> reverse(tail_transpose(M, [])).

tail_transpose([[] | _], Acc) -> Acc;
tail_transpose(M, Acc) ->
    {Heads, Tails} = tail_partition_transpose(M, [], []),
    tail_transpose(Tails, [Heads|Acc]).

tail_partition_transpose([], Heads, Tails) -> {reverse(Heads), reverse(Tails)};
tail_partition_transpose([[H|T] | Rest], Heads, Tails) ->
    tail_partition_transpose(Rest, [H|Heads], [T|Tails]).


read_int_line() -> read_int_line(",").
read_int_line(Sep) ->
    SeqLine = lists:droplast(io:get_line("")),
    SplitArgs = string:split(SeqLine, Sep, all),
    lists:map(fun list_to_integer/1, SplitArgs).
