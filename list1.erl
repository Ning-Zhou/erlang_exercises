-module(list1).

-export([max/1, min/1, min_max/1]).

min([H | T]) -> min1(T, H).

min1([], Accu) -> Accu;
min1([H | T], Accu) when H > Accu -> min1(T, Accu);
min1([H | T], _) -> min1(T, H).

max([H | T]) -> max1(T, H).

max1([], Accu) -> Accu;
max1([H | T], Accu) when H < Accu -> max1(T, Accu);
max1([H | T], _) -> max1(T, H).

min_max(L) -> [min(L), max(L)].
