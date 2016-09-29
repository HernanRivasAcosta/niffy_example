%%==============================================================================
%% This example makes use of a separate C file
%%==============================================================================

-module(link_c_files_ex).

-niffy(#{functions => [double_factorial/1],
         options   => [% This is the header file of our existing C code
                       {includes,     ["../../c_src/example.h"]},
                       % And here are files we want to compile in our object
                       {extra_files,  ["c_src/example.c"]}]}
         ).

-export([double_factorial/1]).

%%==============================================================================
double_factorial(_) ->
  "unsigned int double_factorial(unsigned int n)
   {
     return 2 * factorial(n);
   }".