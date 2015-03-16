-module(pretty_print_demo).
-export([demo/0]).

-record(person, {gender,age,name}).
-record(family, {father=#person{gender=male }, mother=#person{gender=female}, kids=[]}).


demo()->
    F = #family{father=#person{age=35, name= "Robert"}, mother=#person{age=30, name="Lisa"}, kids=["Lucas","Erik"]},
    print(F).
    
print(Data)->
    io:format(io_lib_pretty:print(Data, fun rec_def_fun/2)).




rec_def_fun(family, _) -> 
    record_info(fields, family);
rec_def_fun(person, _) -> 
    record_info(fields, person).









