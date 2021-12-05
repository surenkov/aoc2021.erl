-module(day02_1).

-export([main/1]).

main(_) ->
    Commands = read_input(),
    Result   = move_submarine(Commands),
    io:format("~w~n", [Result]).

read_input() -> lists:reverse(read_input([])).
read_input(Acc) ->
    case io:fread("", "~a ~d") of
        {ok, [Action, Amount]} -> read_input([{Action, Amount} | Acc]);
        eof                      -> Acc
    end.


move_submarine(CommandSeq) -> move_submarine({0, 0}, CommandSeq).

move_submarine({Pos, Depth}, []) -> Pos * Depth;
move_submarine({Pos, Depth}, [Action | Rest]) ->
    case Action of
        {forward, X} -> move_submarine({Pos + X, Depth}, Rest);
        {down, X}    -> move_submarine({Pos, Depth + X}, Rest);
        {up, X}      -> move_submarine({Pos, Depth - X}, Rest)
    end.
