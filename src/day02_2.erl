-module(day02_2).

-export([main/1]).

main(_) ->
    Commands = read_input(),
    Result   = move_submarine(Commands),
    io:format("~w~n", [Result]).

read_input() -> lists:reverse(read_input([])).
read_input(Acc) ->
    case io:fread("", "~a ~d") of
        {ok, [Action, Amount]} -> read_input([{Action, Amount} | Acc]);
        eof                    -> Acc
    end.


move_submarine(CommandSeq) -> move_submarine({0, 0, 0}, CommandSeq).

move_submarine({Pos, Depth, Aim}, [Action | Rest]) ->
    case Action of
        {down, X}    -> move_submarine({Pos, Depth, Aim + X}, Rest);
        {up, X}      -> move_submarine({Pos, Depth, Aim - X}, Rest);
        {forward, X} -> move_submarine({Pos + X, Depth + (Aim * X), Aim}, Rest)
    end;
move_submarine({Pos, Depth, _}, []) -> Pos * Depth.
