
function player = agent_y(varargin)
    % AGENT_Y
    % agent_y(name,options)
    % select an x-agent to select an action
    
    %% assert
    assert(length(varargin)<3,'agent_y: error. too many arguments');

    %% warning
    %#ok<*ERTAG,*NODEF>
    
    %% default options
    jb('name    = varargin{1};');
    jb('options ¬ varargin{2} : struct();');
    options = default(options);

    %% choose
    switch(name)
        case'human'
            player = human(options);
        case 'random'
            player = random(options);
        case 'explorer'
            player = explorer(options);
        otherwise
            error('agent_y: unknown "%s"',name);
    end

end