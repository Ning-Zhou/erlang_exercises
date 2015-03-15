-module(profile).
-export([run/0]).

run()->
    rna_transcription:to_rna("abcd").



