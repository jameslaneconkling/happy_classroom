% compute disjoint of (Set1, Set2, DisjointSet)
% assumes Set2 is a subset of Set1
disjoint(Set, [], Set).
disjoint(Set, [Head|Tail], Disjoint) :-
    delete(Set, Head, RemainingDisjoint),
    disjoint(RemainingDisjoint, Tail, Disjoint).

% compute N Choose K
choose(_, 0, []).
choose([Head|Tail], K, [Head|Sublist]) :-  % add Head to Sublist
    K1 is -(K, 1),
    choose(Tail, K1, Sublist).
choose([_|Tail], K, Sublist) :-      % don't add Head to Sublist
    K > 0,                                    % make sure this rule doesn't duplicate the basecase
    choose(Tail, K, Sublist).

% compute N Choose K, w/ the constraint that the first element be included in all sublists
% this maintains sort order across multiple sublist groups, preventing duplicates such as:
% choose_all([1,2,3,4], 2, X).
% X = [[1,2],[3,4]];
% X = [[1,3],[2,4]];
% X = [[1,4],[2,3]];
% and
% X = [[2,3],[1,4]];
% X = [[2,4],[1,3]];
% X = [[3,4],[1,2]];
choose_first([Head|Tail], K, [Head|SubList]) :-
    K1 is -(K, 1),
    choose(Tail, K1, SubList).

% group all elements in a set into a set of all possible subsets of size = K or size = ()K - 1)
choose_all([], _, []).
choose_all(List, K, [SubList|SubLists]) :-        % List is evenly dividable by K
    length(List, ListLength),
    0 is mod(ListLength, K),
    choose(List, K, SubList),
    disjoint(List, SubList, RemainingList),
    choose_all(RemainingList, K, SubLists).
choose_all(List, K, [SubList|SubLists]) :-        % List is not evenly dividable by K; create a subgroup of size K - 1
    length(List, ListLength),
    mod(ListLength, K) > 0,
    K1 is -(K, 1),
    choose(List, K1, SubList),
    disjoint(List, SubList, RemainingList),
    choose_all(RemainingList, K, SubLists).
