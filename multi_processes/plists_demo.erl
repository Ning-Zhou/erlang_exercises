-module(plists_demo).
-export([demo/0]).

demo()->
    plists:map(fun print/1, lists:seq(1,100)).
    
print(Data)->
    io:format("~p\n", [Data]).

