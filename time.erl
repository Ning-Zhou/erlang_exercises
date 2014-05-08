-module(time).
-export([swedish_date/0]).
-import(string, [right/3]).
swedish_date()->
    Date = date(),
    Year = element(1, Date),
    Month = element(2, Date),
    Day = element(3, Date),
    Year_string = integer_to_list(Year),
    Month_string = integer_to_list(Month),
    Day_string = integer_to_list(Day),
    right(Year_string, 2, $0)++right(Month_string, 2, $0)++right(Day_string, 2, $0).
