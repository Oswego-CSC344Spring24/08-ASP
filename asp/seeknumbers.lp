% Ethan Uwiduhaye euwiduha@oswego.edu

diff(0,1). diff(0,-1). diff(1,0). diff(-1,0).

{ path(X1,Y1,X2,Y2) : diff(A,B), X2=(X1+A), Y2=(Y1+B), cell(X2,Y2) } = 1 :- first(X1,Y1).

{ path(X1,Y1,X2,Y2) : diff(A,B), X2=(X1+A), Y2=(Y1+B), cell(X2,Y2) } 1 :- path(_,_,X1,Y1).

:- cell(X,Y), not path(_,_,X,Y), not first(X,Y).

:- cell(X,Y), 2{path(_,_,X,Y)}.

:- final(X1,Y1), path(X1,Y1,X2,Y2).

bend(X,Y) :- path(X0,Y0,X,Y), path(X,Y,X2,Y2), X0=X, Y=Y2.
bend(X,Y) :- path(X0,Y0,X,Y), path(X,Y,X2,Y2), Y0=Y, X=X2.

helper(X,Y,0) :- first(X,Y).

helper(X,Y,L) :- hint(X,Y,L).

helper(X,Y,L) :- path(X0,Y0,X,Y), not bend(X,Y), helper(X0,Y0,L), not hint(X,Y,_).

helper(X,Y,L-1) :- path(X0,Y0,X,Y), bend(X,Y), helper(X0,Y0,L), L>0, not hint(X,Y,_).

:- helper(X,Y,L), final(X,Y), L>0.

:- helper(X,Y,L), L>0, path(X,Y,X2,Y2), hint(X2,Y2,N).

:- cell(X,Y), not helper(X,Y,_).

% Display
#show path/4.
