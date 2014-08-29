
try
    %% clean
    clean;

    %% tokens
    % [o] = option
    % [g] = game
    % [x] = Xactor
    % [y] = Yactor
    jb('o ¬ o : default();');
    jb('g ¬ g : game(o);');
    jb('x ¬ x : agent_x(''convex'',o);');   ... "distil" "masker" "convex"
    jb('y ¬ y : agent_y(''xplore'',o);');   ... "humane" "random" "xplore"

    %% variables
    % [s] = status
    % [r] = reward
    % [i] = ignore
    % [a] = action
    [s,r,i,a] = deal(g.status , 0 , true, false(1,o.n_action));

    %% loooooop
    while 1
        g.print();
        ...g.pause();
        
        a = y.step(s,r,i);
        x.step(s,r,i,a);
        [s,r,i] = g.step(a);
    end
    
catch err
    clean;
    rethrow(err);
end
