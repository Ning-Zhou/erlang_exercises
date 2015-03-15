-module(profile).
-export([run1/1,run2/1,string/1,profile/0]).

string(Num)->
    string:copies("ACGTGGTCTTAA",Num).

profile()->
    String = string(100000),
    fprof:trace(start),
    run1(String),
    run2(String),
    fprof:trace(stop),
    ok.
    

run1(String)->    
    rna_transcription:to_rna(String),
    ok.

run2(String)->
    rna_transcription:to_rna_body_rec(String),
    ok.


