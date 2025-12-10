/* 

 In this project you will write a prolog program that can solve a maze, creating a predicate 
find_exit/2 for the user to query. As a reminder the format f/N represents a predicate with 
functor f and arity N.

each cell can be a f, w, s, or e
    f = floor (empty)
    w = wall (not passable)
    s = start (only one)
    e = exit (can be more than one)

action can be left, right, up, or down
    left = previous column
    right = next column
    up = previous row
    down = next row

*** tips ***
- predicate can have more than one rule
- take advantage of unification
- can use negation-as-failure (\+)
- can load multiple files
- can use helper predicates

overall structure of the program:

represent positions as row and col 
    0-based
validate maze
find start position
if actions r given then do the moves
    edge case checks
if action is variable
    search for path with DFS

*/

% find entry point

    % find_exit

    find_exit(Maze, Actions) :-
        valid_maze(Maze),
        start_pos(Maze, StartPos),
        (   var(Actions)
        ->  exit_path(Maze, StartPos, [], [StartPos], Reverse_Actions),
            reverse(Reverse_Actions, Actions)
        ;   simulate_actions(Maze, StartPos, Actions, EndPos),
            cell_at(Maze, EndPos, e)
        ).

% validate maze

    % valid_maze

    valid_maze(Maze) :-
        

    % check_row_lengths

    % count_cells

    % row_count

    % all_cells_valid

    % all_cells_valid_row

% maze helpers

    % cell_at
    % in_bounds
    % start_pos

% action given, follow actions

    % move

% simulate given list of actions

    % simulate_actions []
    % simulate_actions [Act | Rest]

% search for path to exit

    % base case
        % exit_path (Maze, (R, C), ACC, _, ACC)

    % recursive case
        % exit_path (Maze, (R, C), ACC, Visited, Path)


