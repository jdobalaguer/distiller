
function player = agent_x(varargin)
    % AGENT_X
    % agent_x(name,options)
    % select an x-agent to find regularities
    
    %% assert
    assert(length(varargin)<3,'agent_x: error. too many arguments');

    %% warning
    %#ok<*ERTAG,*NODEF>
    
    %% default options
    jb('name    = varargin{1};');
    jb('options ¬ varargin{2} : struct();');
    options = default(options);

    %% choose
    switch(name)
        case'distil'
            player = distil(options);
        case 'masker'
            player = masker(options);
        case 'convex'
            player = convex(options);
        otherwise
            error('agent_x: unknown "%s"',name);
    end

end