# Happy Classroom

Calculate optimal groupings of a target population into a set of subsets of equal/near-equal size.  Exhaustively searches all possible subset combinations while avoiding duplicate search branches.  I.e. having searched subset `[1, 2]`, algorithm will skip `[2,1]`; and having searched result set `[[1,2], [3,4]]`, algorithm will skip `[[3,4], [1,2]]`.

Written for the [SWI Prolog](http://www.swi-prolog.org/) environment.


### Example

```prolog
?- classroom([p(1), p(2), p(3), p(4), p(5), p(6)], 2, Classroom).
Classroom = groups([[p(1), p(2)], [p(3), p(4)], [p(5), p(6)]], 21) ;
Classroom = groups([[p(1), p(2)], [p(3), p(5)], [p(4), p(6)]], 21) ;
Classroom = groups([[p(1), p(2)], [p(3), p(6)], [p(4), p(5)]], 21) ;
Classroom = groups([[p(1), p(3)], [p(2), p(4)], [p(5), p(6)]], 21) ;
Classroom = groups([[p(1), p(3)], [p(2), p(5)], [p(4), p(6)]], 21) ;
Classroom = groups([[p(1), p(3)], [p(2), p(6)], [p(4), p(5)]], 21) ;
Classroom = groups([[p(1), p(4)], [p(2), p(3)], [p(5), p(6)]], 21) ;
Classroom = groups([[p(1), p(4)], [p(2), p(5)], [p(3), p(6)]], 21) ;
Classroom = groups([[p(1), p(4)], [p(2), p(6)], [p(3), p(5)]], 21) ;
Classroom = groups([[p(1), p(5)], [p(2), p(3)], [p(4), p(6)]], 21) ;
Classroom = groups([[p(1), p(5)], [p(2), p(4)], [p(3), p(6)]], 21) ;
Classroom = groups([[p(1), p(5)], [p(2), p(6)], [p(3), p(4)]], 21) ;
Classroom = groups([[p(1), p(6)], [p(2), p(3)], [p(4), p(5)]], 21) ;
Classroom = groups([[p(1), p(6)], [p(2), p(4)], [p(3), p(5)]], 21) ;
Classroom = groups([[p(1), p(6)], [p(2), p(5)], [p(3), p(4)]], 21) ;
false.
```
