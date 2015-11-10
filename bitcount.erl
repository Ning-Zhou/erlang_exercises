-module(bitcount).
-export([bitcount/1]).

bitcount(Int) ->
    bitcount(binary:encode_unsigned(Int), 0).

bitcount(<<>>, Acc) ->
    Acc;
bitcount(0, Acc) ->
    Acc;
bitcount(<<B:1, R/bitstring>>, Acc) ->
    bitcount(R, Acc + B).


