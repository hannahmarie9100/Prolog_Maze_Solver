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
        Maze = [FirstRow | _],
        FirstRow \= [],
        maplist(check_row_lengths(FirstRow), Maze),
        count_cells(Maze, s, NumS),
        NumS =:= 1,
        count_cells(Maze, e, NumE),
        NumE >= 1,
        all_cells_valid(Maze).

    % check_row_lengths

    check_row_lengths(Template, Row) :-
        length(Template, L),
        length(Row, L).

    % count_cells

    count_cells([], _, 0).
    count_cells([Row | Rest], CellType, Count) :-
        row_count(Row, CellType, RowCount),
        count_cells(Rest, CellType, RestCount),
        Count is RowCount + RestCount.

    % row_count

    row_count([], _, 0).
    row_count([Cell | Rest], CellType, Count) :-
        row_count(Rest, CellType, RestCount),
        (   Cell == CellType
        ->  Count is RestCount + 1
        ;   Count is RestCount
        ).

    % all_cells_valid

    all_cells_valid([]).
    all_cells_valid([Row | Rest]) :-
        all_cells_valid_row(Row),
        all_cells_valid(Rest).

    % all_cells_valid_row

    all_cells_valid_row([]).
    all_cells_valid_row([Cell | Rest]) :-
        member(Cell, [f, w, s, e]),
        all_cells_valid_row(Rest).

% cell_at

    cell_at(Maze, (R, C), Cell) :-
        nth0(R, Maze, Row),
        nth0(C, Row, Cell).

    % in_bounds

    in_bounds(Maze, (R, C)) :-
        R >= 0,
        length(Maze, NumRows),
        R < NumRows,
        Maze = [FirstRow | _],
        length(FirstRow, NumCols),
        C >= 0,
        C < NumCols.

    % start_pos

    start_pos(Maze, (R, C)) :-
        nth0(R, Maze, Row),
        nth0(C, Row, s).

% action given, follow actions

     % move

    move(left, 0, -1).
    move(right, 0, 1).
    move(up, -1, 0).
    move(down, 1, 0).

% simulate given list of actions

   
% simulate_actions []

    simulate_actions(_Maze, Pos, [], Pos).

    % simulate_actions [Act | Rest]

    simulate_actions(Maze, (R, C), [Act | Rest], EndPos) :-
        move(Act, DR, DC),
        NewR is R + DR,
        NewC is C + DC,
        NewPos = (NewR, NewC),
        in_bounds(Maze, NewPos), % stay inside the maze
        cell_at(Maze, NewPos, Cell),
        Cell \= w, % cant move into a wall
        simulate_actions(Maze, NewPos, Rest, EndPos).

% search for path to exit

    % base case
        % exit_path (Maze, (R, C), ACC, _, ACC)

        exit_path(Maze, (R, C), ACC, _Visited, ACC) :-
            cell_at(Maze, (R, C), e).

    % recursive case
        % exit_path (Maze, (R, C), ACC, Visited, Path)

    exit_path(Maze, (R, C), ACC, Visited, Path) :-
        move(Act, DR, DC),  
        NewR is R + DR,
        NewC is C + DC,
        NewPos = (NewR, NewC),
        in_bounds(Maze, NewPos),
        \+ member(NewPos, Visited),
        cell(Maze, NewPos, NewCell), y6t fdcxzfdswezzzzzzzz       NewCell \= w,
        exit_path(Maze, NewPos, [Act | ACC], [NewPos | Visited], Path).


