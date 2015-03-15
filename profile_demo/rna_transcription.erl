-module(rna_transcription).
-export([to_rna/1,to_rna_body_rec/1]).

-type dna_nuc() :: 71 | 67 | 84 | 65. %% $G|$C|$T|$A does not work
-type dna_string() :: [dna_nuc()].
-type rna_nuc() :: 71 | 67 | 84 | 85.
-type rna_string() :: [rna_nuc()].

-spec(to_rna(dna_string())->rna_string()).
to_rna($G) -> $C;
to_rna($C) -> $G;
to_rna($T) -> $A;
to_rna($A) -> $U;
to_rna(String) -> lists:reverse(to_rna(String, [])).

to_rna([], Accu) -> Accu;
to_rna([H|T], Accu) -> to_rna(T, [to_rna(H)|Accu]).

-spec(to_rna_body_rec(dna_string())->rna_string()).
to_rna_body_rec([])-> [];
to_rna_body_rec($G) -> $C;
to_rna_body_rec($C) -> $G;
to_rna_body_rec($T) -> $A;
to_rna_body_rec($A) -> $U;
to_rna_body_rec([H|T]) -> [to_rna(H)] ++ to_rna(T).


















