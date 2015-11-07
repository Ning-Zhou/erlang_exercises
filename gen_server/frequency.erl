-module(frequency).
-behaviour(gen_server).
-export([init/1, start/0, stop/0, allocate/0, deallocate/1, handle_call/3, handle_cast/2, terminate/2, handle_info/2, test_trap_exit/0]).

-include("frequency.hrl").

test_trap_exit()->
    spawn(fun()-> frequency!{'EXIT', self(), hello} end).

start()->
    gen_server:start_link({local, frequency}, frequency, [],[]).

stop()->
    gen_server:cast(frequency, stop).

-spec init(_Args) -> {ok, frequencise()} | {stop, reason()}.
init(_Args) ->
    process_flag(trap_exit, true),
    Frequencies = {get_frequencies(),[]},
    {ok, Frequencies}.

get_frequencies()->
    [11,12,13,14,15].

%% Client interface
-spec allocate() -> freq().
allocate() ->
    gen_server:call(frequency, {allocate, self()}).

-spec deallocate(freq()) -> ok.
deallocate(Freq)->
    gen_server:cast(frequency, {deallocate, Freq}).

%% call back function for client interface
handle_call({allocate, Pid}, _From, Freqencies) ->
    {NewFrequencies, AllocatedFreq} = allocate(Freqencies, Pid),
    {reply, AllocatedFreq, NewFrequencies}.

allocate({RemainingFreq,AllocatedFreqList}, Pid)->
    case RemainingFreq of
	[] ->
	    {error, no_frequency};
	[AllocatedFreq|NewRemainingFreqList] -> 
	    {{NewRemainingFreqList,
	      [{AllocatedFreq,Pid}|AllocatedFreqList]},
	     AllocatedFreq}
    end.

handle_cast({deallocate, Freq}, Frequencies)->
    NewFrequencies = deallocate(Freq, Frequencies),
    {noreply, NewFrequencies};
handle_cast(stop, Frequencies) ->
    {stop, normal, Frequencies}.

deallocate(Freq, {RemainingFreqs, AllocatedFreqList})->
    NewRemainingFreqs = [Freq|RemainingFreqs],
    NewAllocatedFreList= lists:keydelete(Freq,1,AllocatedFreqList),
    {NewRemainingFreqs, NewAllocatedFreList}.

handle_info(Msg, Frequencise)->
    io:format("Received message ~p~n",[Msg]),
    {noreply,Frequencise}.
			 
terminate(Reason, _Frequencies)->
    io:format("Server terminated with reason ~p~n",[Reason]),
    ok.



%% below test shows that handle_info can not handle 'EXIT' signals
%% But actually, the shell process is supervisor, 
%% so, we should use test_trap_exit() to run the test

%% 65> frequency:start().
%% {ok,<0.188.0>}
%% 66> frequency!hello.  
%% Received message hello
%% hello
%% 67> frequency!{'EXIT', self(), hello}.
%% Server terminated with reason hello

%% =ERROR REPORT==== 7-Nov-2015::22:58:09 ===
%% ** Generic server frequency terminating 
%% ** Last message in was {'EXIT',<0.179.0>,hello}
%% ** When Server state == {[11,12,13,14,15],[]}
%% ** Reason for termination == 
%% ** hello
%% ** exception exit: hello


%% 5> c(frequency).
%% frequency.erl:2: Warning: undefined callback function code_change/3 (behaviour 'gen_server')
%% {ok,frequency}
%% 6> frequency:start().              
%% {error,{already_started,<0.42.0>}}
%% 7> frequency:test_trap_exit(). 
%% Received message {'EXIT',<0.61.0>,hello}
%% <0.61.0>

