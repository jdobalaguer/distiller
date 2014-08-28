
try
    %% clean
    clean;

    %% tokens
    jb('o ¬ o : default();');                   % options
    jb('g ¬ g : game(o);');                     % game
    jb('x ¬ x : agent_x(''masker'',o);');       % agent X : "distiller" "masker"
    jb('y ¬ y : agent_y(''explorer'',o);');        % agent Y : "human"     "random"   "explorer"

    %% variables
    [s,r,t,a] = deal(g.status , 0 , true, false(1,o.n_action));

    %% loooooop
    while 1
        g.print();
        ...g.pause();

        % agents
        a = y.step(s,r,t);
        x.step(s,r,t,a);

        % game
        [s,r,t] = g.step(a);
    end
    
catch err
    rethrow(err);
end