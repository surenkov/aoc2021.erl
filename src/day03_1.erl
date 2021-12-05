-module(day03_1).
-mode(compile).

-export([main/1]).

main(_) ->
    Input = read_mat(),
    BitMap = count_common(Input),
    G = gamma(BitMap),
    E = epsilon(BitMap),
    io:format("~p * ~p = ~p~n", [G, E, G*E]).

gamma(CMat)   -> bits_to_int(CMat).
epsilon(CMat) -> bits_to_int(invert(CMat)).

read_mat() -> lists:reverse(read_mat([])).
read_mat(Acc) ->
    case io:fread("", "~s") of
        {ok, [Line]} -> read_mat([Line | Acc]);
        eof          -> to_int_mat(Acc)
    end.

count_common(M) ->
    Len = length(M),
    Half = Len div 2,
    [(lists:sum(X) + Half) div Len || X <- utils:transpose(M)].

invert([X|M]) -> [1-X | invert(M)];
invert([]) -> [].

to_int_mat([X | M]) -> [[C - $0 || C <- X] | to_int_mat(M)];
to_int_mat([]) -> [].

bits_to_int(BitList) ->
    Len = length(BitList),
    <<I:Len>> = << <<B:1>> || B <- BitList>>,
    I.
