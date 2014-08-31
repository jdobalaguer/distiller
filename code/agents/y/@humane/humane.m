
classdef humane < matlab.mixin.Copyable % handle + copyable
    
    %% PROPERTY
    properties
        options
    end
    
    %% WARNING
    %#ok<*INUSD,*ST2NM>
    
    %% METHOD
    methods
        function obj = humane(options)
            obj.options = options;
        end
        
        function action = step(obj, status, reward, terminal)
            n_action = obj.options.n_action;
            action   = [];
            while any(size(action)~=[1,n_action])
                action = str2num(input('action: ','s'));
            end
            action = logical(action);
        end
    end
    
end
