-module(utils).

-mode(compile).

-import(lists, [reverse/1]).
-export([transpose/1, tail_transpose/1]).

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
