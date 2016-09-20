%%==============================================================================
%% This example shows how you can use niffy with minimal configuration
%%==============================================================================

-module(basic_ex).
-export([square/1, nat_log/1, test/0]).
% With only need a list of functions, niffy has enough to do its magic. And this
% is actually pretty powerful when coupled with custom erl_opts
-niffy([square/1, nat_log/1]).

%%==============================================================================
% A basic C function to return the square of a number
square(_) ->
  "unsigned int square(int a)
   {
     return a * a;
   }".

% You can still use includes when using the basic niffy configuration
nat_log(_) ->
  "#include <math.h>
   double nat_log(double a)
   {
     double logA = log(a);
     return logA;
   }".

%%==============================================================================
test() ->
  % We can square a number
  25 = square(5),
  % But we need to be careful with types, a float is not an integer
  ok = try 25 = square(5.0)
       catch error:badarg -> ok
       end,

  % Now, lets test the function receiving a double (and having an include)
  NatLog = math:log(1234.0),
  NatLog = nat_log(1234.0),
  % This function is also picky about types, this one demands a floating point
  ok = try NatLog = nat_log(1234)
       catch error:badarg -> ok
       end,

  ok.