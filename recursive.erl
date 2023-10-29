-module(recursive).
-export([fac/1, len/1, tail_fac/1, tail_fac/2]).

% Recursive definition of factorial function using guards.
fac(N) when N == 0 -> 1;
fac(N) when N > 0 -> N * fac(N - 1). 

% Recursive definition of length function for lists using guards.
len([]) -> 0;
len([_|T]) -> 1 + len(T).

% Tail recursive definition for factorial function with multiple arity overloads.
tail_fac(N) -> tail_fac(N, 1).

tail_fac(0, Acc) -> Acc;
tail_fac(N, Acc) when N > 0 -> tail_fac(N - 1, N * Acc). 

% Tail recursive definition for length function for lists with multiple arity overloads.
tail_len(L) -> tail_len(L, 0).

tail_len([], Acc) -> Acc;
tail_len([_|T], Acc) -> tail_len(T, Acc + 1).

% Recursive definition for duplication function using guards.
duplicate(0, _) ->
    [];
duplicate(N,Term) when N > 0 ->
    [Term|duplicate(N-1, Term)].

% Tail recursive definition for duplication function with multiple arity overloads.
tail_duplicate(N, Term) ->
    tail_duplicate(N, Term, []).

tail_duplicate(0, _, List) ->
    List;
tail_duplicate(N, Term, List) ->
    tail_duplicate(N-1, Term, [Term|List]).

% Recursive definition for list reversal function.
reverse([]) ->
    []; 
reverse([H|T]) ->
    reverse(T) ++ [H].

% Tail recursive definition for list reversal function.
tail_reverse(L) ->
    tail_reverse(L, []).

tail_reverse([], Acc) ->
    Acc;
tail_reverse([H|T], Acc) ->
    tail_reverse(T, [H|Acc]).

% Recursive definition for sublist function (splits list in two after N elements).
sublist(_,0) ->
    [];
sublist([], _) ->
    [];
sublist([H|T], N) when N > 0 ->
    [H|sublist(T, N-1)].

% Tail recursive definition of sublist function using reverse.
tail_sublist(L, N) ->
    tail_reverse(tail_sublist(L, N, [])).

tail_sublist(_,0, Acc) ->
    Acc;
tail_sublist([], _, Acc) ->
    Acc;
tail_sublist([H|T], N, Acc) when N > 0 ->
    tail_sublist(T, N - 1, [H|Acc]).

% The classic zip function.
zip([], []) ->
    [];
zip([X|Xs], [Y|Ys]) ->
    [{X, Y} | zip(Xs, Ys)].

% The same as above, but more lenient.
lenient_zip([], _) ->
    [];
lenient_zip(_, []) ->
    [];
lenient_zip([X|Xs], [Y|Ys]) ->
    [{X, Y} | lenient_zip(Xs, Ys)].

% Tail recursive definition for zip function.
tail_zip(Xs, Ys) ->
    tail_zip(Xs, Ys, []).

tail_zip([], _, Acc) ->
    Acc;
tail_zip(_, [], Acc) ->
    Acc;
tail_zip([X|Xs], [Y|Ys], Acc) ->
    tail_zip(Xs, Ys, [{X, Y}|Acc]).

% The quicksort algorithm in erlang.
quicksort([]) ->
    [];
quicksort([Pivot|Rest]) ->
    {Smaller, Larger} = partition(Pivot, Rest, [], []),
    quicksort(Smaller) ++ [Pivot] ++ quicksort(Larger).

partition(_, [], Smaller, Larger) ->
    {Smaller, Larger};
partition(Pivot, [H|T], Smaller, Larger) ->
    if H =< Pivot ->
            partition(Pivot, T, [H|Smaller], Larger);
       H > Pivot ->
            partition(Pivot, T, Smaller, [H|Larger])
    end.

% A more readable, but less performant quicksort implementation.
lc_quicksort([]) ->
    [];
lc_quicksort([Pivot|Rest]) ->
    lc_quicksort([Smaller || Smaller <- Rest, Smaller =< Pivot])
        ++ [Pivot] ++
        lc_quicksort([Larger || Larger <- Rest, Larger > Pivot]).

