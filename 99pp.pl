% Ninety-Nine Prolog Problems

% -----------------------------Lists----------------------------

% Problem 01: Find the last element of a list, with the predicate mylast/2
% My solution [WORKS]
mylast(X,[H|T]) :- X = H, T = [];mylast(X,T).

% Correct solution
% my_last(X,[X]).
% my_last(X,[_|L]) :- my_last(X,L).

% Problem 02: Find the last but one element of a list
% My solution [WORKS]
lastButOne(X,[X|[_]]).
lastButOne(X,[_|T]) :- lastButOne(X,T). 

% Correct solution
% last_but_one(X,[X,_]).
% last_but_one(X,[_,Y|Ys]) :- last_but_one(X,[Y|Ys]).

% Problem 03: Find the K'th element of a list
% My solution [WORKS - adding K > 0 is more efficient]
kth(X,0,[X|_]).
kth(X,K,[_|T]) :- Z is K - 1,kth(X,Z,T).

% Correct solution
% element_at(X,[X|_],1).
% element_at(X,[_|L],K) :- K > 1, K1 is K - 1, element_at(X,L,K1).

% Problem 04: Find the number of elements of a list
% My solution [DOES NOT WORK - Bad position of the recursion lead to bad instantiated variable: 
                                                                        % ERROR: Arguments are not sufficiently instantiated
                                                                        % ERROR: In:
                                                                        % ERROR:    [8] count(_6822,[a,b|...])
                                                                        % ERROR:    [7] <user>]
count(X,[]) :- X = 0.
count(X,[_|T]) :- K is X + 1,count(K,T).

% Correct solution
mycount(0,[]).
mycount(K,[_|T]) :- mycount(X,T),K is X + 1.

% Problem 05: Reverse a list
% My solution [DOES NOT WORK - Result: X = [[[[d]|c]|b]|a] ;]
revers(X,L1) :- rev(X,L1,[]).

rev([],D,D).
rev([A|B],L1,Z) :- rev(B,L1,[A|Z]).

% Correct solution
myreverse(L1,L2) :- myrev(L1,L2,[]).

myrev([],L2,L2).
myrev([X|Xs],L2,Acc) :- myrev(Xs,L2,[X|Acc]).

% Problem 06: Find out wether a list is palindrome
% My solution [DOES NOT WORK]

 pal([H],[H]).
 pal([H|T],L1) :- pal(T,[H|L1]).
 pal([H|T],[A|Tb]) :- A= Z.
 pal([H|T],Z):- pal(T,Z).

% Correct solution
palindrome(X) :- myreverse(X,X).

% Problem 07: Flatten a nested list structure
% Transform a list, possibly holding lists as elements into a `flat' list by replacing each list with its elements (recursively).
% My solution [DOES NOT WORK - X = [[[a], [[b]], c]].]

flatn(X,L1) :- fl(X,L1,[]).
fl([],D,D).
fl([H|T],Z,R) :- fl(H,Z,R),fl(T,Z,R).
fl([],_,_).
fl(H,[H|R],R).

% Correct solution
myflatten(X,[X]) :- \+ is_list(X).
myflatten([],[]).
myflatten([X|Xs],Zs) :- myflatten(X,Y), myflatten(Xs,Ys), append(Y,Ys,Zs).

% Problem 08: Eliminate consecutive duplicates of list elements.
% ?- compress([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
% X = [a,b,c,a,d,e]
% My solution [WORKS A LITTLE]

compriess(X,L1) :- comp(X,L1,_).
comp([],[Z|L1],Z).
comp([H|T],L1,H) :- comp(T,L1,H).
comp([H|T],[Z|L1],Z) :- comp(T,L1,H).

% Correct solution
compress([],[]).
compress([X],[X]).
compress([X,X|Xs],Zs) :- compress([X|Xs],Zs).
compress([X,Y|Ys],[X|Zs]) :- X \= Y, compress([Y|Ys],Zs).

% Problem 09: Pack consecutive duplicates of list elements into sublists.
%             If a list contains repeated elements they should be placed in separate sublists.
% ?- pack([a,a,a,a,b,c,c,a,a,d,e,e,e,e],X).
% X = [[a,a,a,a],[b],[c,c],[a,a],[d],[e,e,e,e]]
% My solution
listPack(X,Y) :- listPackAcc(X,Y,[],_).
listPackAcc([],_,_,_).
%listPackAcc([H1|T1],Y,[H1|Z],H1) :- listPackAcc(T1,Y,Z,H1),Y = [Z].
%listPackAcc([N|T1],[Z|T2],Z,H1) :- listPackAcc(T1,T2,[N],N).

listPackAcc([H1|T1],Y,[H1|Z],H1) :- listPackAcc(T1,Y,[H1|Z],H1).
listPackAcc([H1|T1],[N,Z|T2],Z,N) :- listPackAcc(T1,T2,[H1],H1).


test(X) :- teest(X,[]).
teest([],_).
teest([H1|T1],[H1|T2]) :- teest(T1,T2).

% ------------------------------Arithmetics-------------------------------------------

% Problem 31: Determine whether a given integer number is prime
% My solution:
prim(2).
prim(X) :- primm(X,Y).
primm(X,Y) :- Z is X/2,Y is Y + Z,primm(Z,Y),(Y < X -> true;false).

% Problem 32: Determine the greatest common divisor of two positive integer numbers
% My solution: [WORKS]
gcd(A,G,A) :- G =:= 0,!.
gcd(A,B,G) :- X is div(A,B),Y is mod(A,B),A is X * B + Y,gcd(B,Y,G).

% Correct solution:
% gcd(X,0,X) :- X > 0.
% gcd(X,Y,G) :- Y > 0, Z is X mod Y, gcd(Y,Z,G).

% Define gcd as an arithmetic function; so you can use it like this:
% G is gcd(36,63).
gcd(A,G) :- G =:= 0,!.
gcd(A,B,G) :- X is div(A,B),Y is mod(A,B),A is X * B + Y,gcd(B,Y,G).

% Correct solution:

% Problem 33: Determine whether two positive integer numbers are coprime
% My solution:
coprime(A,B) :- gcd(A,B) is 1.

% Correct solution:

% Problem 34: Calculate Euler's totient function phi(m)
% My solution:
