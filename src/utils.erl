-module(utils).

-mode(compile).
-compile(export_all).

transpose([[] | _]) -> [];
transpose(M) -> [[H || [H|_] <- M] | transpose([T || [_|T] <- M])].
