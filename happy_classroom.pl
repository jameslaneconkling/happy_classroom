% compute disjoint of (Set1, Set2, DisjointSet)
% assumes Set2 is a subset of Set1
disjoint(Set, [], Set).
disjoint(Set, [Head|Tail], Disjoint) :-
    delete(Set, Head, RemainingDisjoint),
    disjoint(RemainingDisjoint, Tail, Disjoint).

% compute N Choose K as a subset
choose(_, 0, []).
choose([Head|Tail], K, [Head|Sublist]) :-  % add Head to Sublist
    K1 is -(K, 1),
    choose(Tail, K1, Sublist).
choose([_|Tail], K, Sublist) :-      % don't add Head to Sublist
    K > 0,                                    % make sure this rule doesn't duplicate the basecase
    choose(Tail, K, Sublist).

% compute N Choose K as a count of all possible subsets
%% choose_count(N, )

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
%% TODO - this only works if all groups are of the same size.  So, we can pad population so that it is evenly divisible by K and ensure no group has more than one filler people
choose_first([Head|Tail], K, [Head|SubList]) :-
    K1 is -(K, 1),
    choose(Tail, K1, SubList).


% group all elements in a set into a set of all possible subsets of size = K or size = ()K - 1)
choose_all([], _, []).
choose_all(List, K, [SubList|SubLists]) :-        % List is evenly dividable by K
    length(List, ListLength),
    0 is mod(ListLength, K),
    choose_first(List, K, SubList),
    disjoint(List, SubList, RemainingList),
    choose_all(RemainingList, K, SubLists).
choose_all(List, K, [SubList|SubLists]) :-        % List is not evenly dividable by K; create a subgroup of size K - 1
    length(List, ListLength),
    mod(ListLength, K) > 0,
    K1 is -(K, 1),
    choose_first(List, K1, SubList),
    disjoint(List, SubList, RemainingList),
    choose_all(RemainingList, K, SubLists).

% sum group according to cost function
% NOTE - this will become more involved
person_cost(p(Cost), Cost).

group_cost([Person], Cost) :-
    person_cost(Person, Cost).
group_cost([Person|Rest], TotalCost) :-
    person_cost(Person, Cost),
    group_cost(Rest, RestCost),
    TotalCost is +(Cost + RestCost).

groups_cost([Group], Cost) :-
    group_cost(Group, Cost).
groups_cost([Group|Rest], Cost) :-
    group_cost(Group, GroupCost),
    groups_cost(Rest, RestCost),
    Cost is +(GroupCost, RestCost).

classroom(List, K, Groups) :-
    choose_all(List, K, GroupsWithoutCost),
    groups_cost(GroupsWithoutCost, Cost),
    Groups = groups(GroupsWithoutCost, Cost).


%% classroom_solution_count(List, K, Groups) :-
% count(N, K) -> ((N - 1) choose (K - 1)) * ((N - K - 1) choose (K - 1)) * ((N - 2K - 1) choose (K - 1)) * ...
% assuming N is evenly divisible by K.  If not, round up to the nearest multiple?
