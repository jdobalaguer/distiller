
classdef xplore < matlab.mixin.Copyable % handle + copyable
    %% WARNING
    %#ok<*INUSD,*INUSL,*AGROW,*ASGLU>
    
    %% PROPERTY
    properties
        options
        actions
        counter
    end
    
    %% METHOD
    methods
        function obj = xplore(options)
            obj.options = options;
            
            % action repertoire
            obj.set_possible_actions(obj.options.n_action);
            
            % counter
            obj.counter = dict();
        end
        
    
        function action = step(obj, status, reward, terminal)
            action = obj.choose_action(status);
        end

        %% set action repertoire
        function set_possible_actions(obj,n_action)
            obj.actions = jb_binarytable(n_action);
        end

        
        %% actions
        
        function count = action_get(obj,status,action)
            memory = [ status(:) ; action(:) ];
            count = obj.counter(memory);
            if isempty(count)
                obj.counter(memory) = 0;
                count = 0;
            end
        end
        
        function action_add(obj,status,action)
            memory = [ status(:) ; action(:) ];
            obj.counter(memory) = obj.counter(memory) + 1;
        end
        
        %% choose action
        function action = choose_action(obj,status)
            s_action = size(obj.actions,1);
            c_action = zeros(1,s_action);
            for i_action = 1:s_action
                action = obj.actions(i_action,:);
                c_action(i_action) = obj.action_get(status,action);
            end
            m_action = min(c_action);
            f_action = find(c_action == m_action);
            f_action = shuffle(f_action);
            action = obj.actions(f_action(1),:);
            obj.action_add(status,action);
        end
    end
end