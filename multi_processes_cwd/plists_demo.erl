-module(plists_demo).
-export([demo/0]).

demo()->
    plists:map(fun cwd_process/1, lists:seq(1,20)).
    
cwd_process(Data)->
    io:format("~p\n", [Data]),
    
    Output = case Data rem 2 of
		 0 -> os:cmd("cd .. && ls");
		 1 -> os:cmd("ls")
	     end,
    io:format("~p\n",[Output]).

    


