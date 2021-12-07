-module(day04_2).
-mode(compile).

-export([main/1]).

main(_) ->
    {InputSeq, Boards} = read_input(),
    {WinBoard, N} = play_bingo(InputSeq, Boards),
    WinRatio = calc_ratio(WinBoard),
    io:format("~p * ~p = ~p~n", [WinRatio, N, WinRatio*N]).

read_input() -> {utils:read_int_line(), read_boards([])}.


play_bingo(InputSeq, Boards) -> play_bingo(InputSeq, Boards, [], nil).

play_bingo([], _, [WinBoard|_], N) -> {WinBoard, N};
play_bingo(_, [], [WinBoard|_], N) -> {WinBoard, N};
play_bingo([Num|InputSeq], Boards, PrevWinners, _) ->
    ProcBoards = [process_board(Num, B) || B <- Boards],
    {Winners, Remains} = lists:partition(fun is_winner/1, ProcBoards),
    play_bingo(InputSeq, Remains, Winners ++ PrevWinners, Num).

process_board(Num, {Rows, Cols}) -> {process_seq(Num, Rows), process_seq(Num, Cols)}.
process_seq(Num, Seq) -> [[Y || Y <- X, Y =/= Num] || X <- Seq].

is_winner({Rows, Cols}) ->
    lists:any(fun is_winner/1, Rows) orelse lists:any(fun is_winner/1, Cols);
is_winner([]) -> true;
is_winner(_)  -> false.


calc_ratio({Rows, _}) -> lists:sum([Y || X <- Rows, Y <- X]).


read_boards(Acc) ->
    case io:fread("", "") of
        {ok, _} -> read_boards([read_single_board([], 5) | Acc]);
        _       -> lists:reverse(Acc)
    end.

read_single_board(Acc, 0) -> prepare_board(lists:reverse(Acc));
read_single_board(Acc, N) ->
    case io:fread("", "~d~d~d~d~d") of
        {ok, Line} -> read_single_board([Line | Acc], N - 1);
        eof        -> read_single_board(Acc, 0)
    end.

prepare_board(Rows) -> {Rows, utils:transpose(Rows)}.
