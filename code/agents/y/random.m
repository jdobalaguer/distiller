
classdef random < matlab.mixin.Copyable % handle + copyable
    %% WARNING
    %#ok<*INUSD>
    
    %% PROPERTY
    properties
        options
    end
    
    %% METHOD
    methods
        function obj = random(options)
            obj.options = options;
        end
        
        function action = step(obj, status, reward, terminal)
            n_action = obj.options.size(2);
            action   = (rand(1,n_action) > 0.5);
        end
    end
end
