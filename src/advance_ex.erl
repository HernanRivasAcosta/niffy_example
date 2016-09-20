%%==============================================================================
%% This example highlights some of the things you can do when using niffy with a
%% more complex configuration
%%==============================================================================

-module(advance_ex).

-niffy(#{% The list of functions we need to niffify. It's the same we use on the
         % basic example
         functions => [return_random/0],
         % You can add a variety of options that modify niffy in a lot of ways
         options   => [% For example, you can use less strict types to avoid the
                       % badarg errors you get by mixing integers and doubles
                       {strict_types, false},
                       % Or you can add some files to include, they are merged
                       % with the ones on the functions
                       {includes, ["<math.h>"]},
                       % You can also set flags on a per file basis =D
                       {flags, ["-pedantic"]},
                       % And yes, you can compile different files with different
                       % compilers. Please, if you ever use this, let me know. I
                       % just can't think of a reason for this feature to exist
                       {compiler, "gcc"}]}%,
         % Finally, you can set the load, upgrade and unload functions. They are
         % optional of course
         %load      => on_load_nif/1,
         %upgrade   => on_upgrade_nif/1,
         %unload    => on_unload_nif/1
         ).

-export([return_random/0]).

%%==============================================================================
% Here, we are returning ERL_NIF_TERM, this means that we don't want niffy to do
% anything on the return values. This is useful even if niffy by default ignores
% all the returns that already use enif_make_*
return_random() ->
  "#include <stdlib.h>
   ERL_NIF_TERM return_random()
   {
     // Let's do the logarithm of a random number, this means that both stdlib.h
     // and math.h were imported successfully
     return enif_make_int(env, log(rand()));
   }".