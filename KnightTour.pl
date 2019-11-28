%Initial_state
initial_state([state(1,1)]).

%Goal_state
goal_state([state(1,4)]).

% defining base confition, 
board(Coord) :-
        0 < Coord,
        Coord < 9.

% Here function show display all the states step by step.
show([]).
show([state(S,G)|Later]) :-
                      write(S),
                      write(G),
                      write(-->),
                      show(Later).

% divide input into two.
div(I,[I|_]).
div(I,[_|J]) :- div(I,J).

% Reverse the list
rev([],List,List).
rev([Head|Tail],L,List) :- rev(Tail,[Head|L],List).

% Check goal state is found or not
solve([state(1,4)|Before],[state(1,4)|Before]).
               
% Define possible places where knight can move from its current state
solve([state(S1,G1)|Before],RawAns) :-
        div([S,G],[[1,2],[2,1],[-2,1],[-1,2],[-2,-1],[-1,-2],[1,-2],[2,-1]]),
        S2 is S1 + S,
        board(S2),
        G2 is G1 + G,             
        board(G2),
        %S2 <= 7, G2 <=7, 
        %S2 >=0, G2 >=0,
        \+ div(state(S2,G2),Before),                                         
        solve([state(S2,G2),state(S1,G1) |Before],RawAns).                   

knight :-
        initial_state(Start),
        goal_state(_),
        solve(Start,RawAns),      
        rev(RawAns,[],FinalAns),        
        write('Start -->'),
        show(FinalAns),
        write('End').