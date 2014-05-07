% exercise
% Write a function which starts 2 processes, and sends a message M times forewards and backwards between them. 
% After the messages have been sent the processes should terminate gracefully.

-module(proc1).
-export([pingpong_messages/1]).

pingpong_messages(M)->
    

% callback function for process 1

callback_proc1()->
    receive 
	{From, Msg} ->
	    io:format("
