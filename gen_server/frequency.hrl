-type freq() :: 11..15.
-type frequencise() :: [freq()].
-type freq_msg()::{allocate,pid()}|{deallocate,freq()}|stop.
-type reason():: atom().

