
function options = default(options)
    % DEFAULT()
    
    %% tips
    % 1 set n_action to double the size if you want to use backward actions
    
    %% defaults
    % game
    jb('options.size     ¬ options.size     : [5,2]');
    jb('options.n_action ¬ options.n_action :    4');
    jb('options.n_status ¬ options.n_status :   10');
    jb('options.n_memory ¬ options.n_memory :   14');
    % x agent
    jb('options.n_time   ¬ options.n_time   :    2');
    
    %% assert
    assert(any(options.n_action == (1:2)*options.size(2)), 'default: error. n_action is wrong');
    assert(prod(options.size) == options.n_status, 'default: error. n_status is wrong');
    assert(options.n_status + options.n_action == options.n_memory, 'default: error. n_memory is wrong');
    
end
