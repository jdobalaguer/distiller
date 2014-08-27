
classdef masker < matlab.mixin.Copyable % handle + copyable
    %% properties
    properties
        % options
        options
        
        % time
        past;           ... time past
        pres;           ... time present
        maps;           ... prediction index
        pred;           ... prediction value
        errr;           ... prediction error
            
        % rule storage
        k_rule;         ... prediction key
        v_rule;         ... prediction rule
    end
    
    methods
        %% constructor
        function obj = masker(options)
            obj.options = options;
            obj.past    =   nan(options.n_memory,1);
            obj.pres    =   nan(options.n_memory,1);
            obj.maps    =   nan(options.n_memory,1);
            obj.pred    =   nan(options.n_memory,1);
            obj.errr    = false(options.n_memory,1);
            obj.k_rule  = {};
            obj.v_rule  = {};
        end
     
        %% methods
        step(obj, status, reward, terminal, action);
        
        board_set(obj,status,action);   ... set past and present values
        board_print(obj,text,present);  ... print board
        
        rule_pred(obj);                 ... predict the present from the past (using stored rules)
        rule_errr(obj);                 ... calculate the error mask between present and prediction
        rule_mend(obj);                 ... mend previous rules to correct for wrong knowledge
        rule_adds(obj);                 ... add a new rule to mend the prediction
        rule_dels(obj);                 ... forget about episodic memory experiences
        rule_simp(obj);                 ... transform rules to make them more simple and general
    end
end