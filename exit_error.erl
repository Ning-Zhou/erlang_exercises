-module(exit_error).
-export([main/0, process2/0, exit/0, error/0]).
main()->
    Pid2 = spawn_link(exit_error, process2, []),
    io:format("main's pid is ~p~n",[self()]),
    io:format("process2's pid is ~p~n",[Pid2]),
    Pid2 ! {self(), "Hello, process 2!"},
%    timer:sleep(10000),
    fun1().
    

process2()->
    process_flag(trap_exit, true),
    receive 
        {Pid, Message}->
            io:format("Message ~p sent from Pid ~p ~n",[Message, Pid])
    end,
    receive 
        {'EXIT', Pid_Sender, Reason }->
            io:format("Exit Reason ~p sent from Pid ~p ~n",[Reason, Pid_Sender]);
         Anything -> io:format("Anything is  ~p ~n",[Anything])

    end.

fun1()->
    erlang:error(trying_exit).

    
exit()->
    exit(trying_exit).

error()->
    erlang:error(trying_error).
