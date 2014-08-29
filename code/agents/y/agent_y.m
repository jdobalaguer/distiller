
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
        case 'humane'
            player = humane(options);
        case 'random'
            player = random(options);
        case 'xplore'
            player = xplore(options);
        otherwise
            error('agent_y: unknown "%s"',name);
    end

end