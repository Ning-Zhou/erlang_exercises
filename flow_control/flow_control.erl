-module(flow_control).
-export([main/0]).

-ifdef(debug).
-define(SYS_DEBUG(Str, Args), io:format(Str, Args)).
-else.
-define(SYS_DEBUG(Str, Args), ok).
-endif.

main()->
    ?SYS_DEBUG("~p:call(~p) called~n", [?MODULE, main]).

% compile with c(flow_control, [{d, debug}]).
