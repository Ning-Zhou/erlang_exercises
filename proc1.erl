% exercise
% Write a function which starts 2 processes, and sends a message M times forewards and backwards between them. 
% After the messages have been sent the processes should terminate gracefully.

-module(proc1).
-export([pingpong_messages/1]).

pingpong_messages(M)->
    Pid2 = spawn (proc1, callback_proc1, []),
    Pid2!{self(), echo_message, 0},
    receive
	{Sender, echo_message, Echoed_Times} when Echoed_Times < M ->
	    io:format("This echo_message is from ~p, it's been received for ~p times~n", [Sender, Echoed_Times+1]),
	    Sender!{self(),N+1};
	{Sender, echo_message, Echoed_Times} when Echoed_Times = M ->
	    ok
    end,
    


% callback function for both process

callback_proc1()->
    receive 
	{Sender, echo_message, Echoed_Times} when Echoed_Times < M ->
	    io:format("This echo_message is from ~p, it's been received for ~p times~n", [Sender, Echoed_Times+1]),
	    Sender!{self(),N+1};
	{Sender, echo_message, Echoed_Times} when Echoed_Times = M ->
	    ok
    end,
    
