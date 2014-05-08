-module(mathStuff).

-export([perimeter/1]).

perimeter({square, Side}) -> Side * 4;
perimeter({circle, Radius}) -> 2 * 3.1415926 * Radius;
perimeter({triangle, A, B, C}) -> A + B + C.
