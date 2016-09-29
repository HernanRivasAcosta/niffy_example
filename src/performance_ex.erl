%%==============================================================================
%% Simple code that shows how much faster can niffy be
%%==============================================================================

-module(performance_ex).
-export([test/0]).
-niffy([solve_niffy/1]).

%%==============================================================================
test() ->
  % Let's solve the 6th euler problem: https://projecteuler.net/problem=6
  % And no, we are not optimizing either
  {TErl1000, V1000} = timer:tc(fun solve_erlang/1, [1000]),
  {TNif1000, V1000} = timer:tc(fun solve_niffy/1,  [1000]),

  {TErl5000, V5000} = timer:tc(fun solve_erlang/1, [5000]),
  {TNif5000, V5000} = timer:tc(fun solve_niffy/1,  [5000]),

  {TErl15000, V15000} = timer:tc(fun solve_erlang/1, [15000]),
  {TNif15000, V15000} = timer:tc(fun solve_niffy/1,  [15000]),

  io:format("Results are in!~n"
            "For the first 1000 natural numbers: ~p (erlang) vs ~p (niffy)~n"
            "For the first 5000 natural numbers: ~p (erlang) vs ~p (niffy)~n"
            "For the first 15000 natural numbers: ~p (erlang) vs ~p (niffy)~n",
            [TErl1000, TNif1000, TErl5000, TNif5000, TErl15000, TNif15000]),

  % On my machine, this returned:
  % For the first 1000 natural numbers: 37 (erlang) vs 5 (niffy)
  % For the first 5000 natural numbers: 187 (erlang) vs 20 (niffy)
  % For the first 15000 natural numbers: 565 (erlang) vs 62 (niffy)

  ok.

%%==============================================================================
solve_erlang(N) ->
  solve_erlang(N, 0, 0).

solve_erlang(0, SumOfSquares, Sum) ->
  (Sum * Sum) - SumOfSquares;
solve_erlang(N, SumOfSquares, Sum) ->
  solve_erlang(N - 1, SumOfSquares + N * N, Sum + N).

solve_niffy(_) ->
  "unsigned long solve_niffy(unsigned long n)
   {
     unsigned long sumOfSquares = 0;
     unsigned long sum = 0;
     while(n)
     {
       sumOfSquares += n * n;
       sum += n;
       n--;
     }
     return (sum * sum) - sumOfSquares;
   }".