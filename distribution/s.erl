-module(s).
-export([s/0]).

s()->
    register(server,self()),
    l().

l()->
    receive
	{M, Pid} ->
	    Pid ! M
    end,
    l().
