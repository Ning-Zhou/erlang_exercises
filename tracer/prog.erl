-module(prog).

-export([main/0, fun1/0]).

main()->
    fun1().

fun1()->
    receive
	{Pid, Msg} ->
	    Pid!Msg,
	    fun2(Msg),
	    fun1();
	stop ->
	    ok
    end.

fun2(H)->
    world.
