
classdef masker < matlab.mixin.Copyable % handle + copyable
    %% masker()
    % masker model
    
    %% novelties
    
    % 1 masks
    % rule key accept a mask (ie, generalized rules).
    % still not checking for not convexity (ie exceptions to generalization)
    
    % 2 printer
    % improved printing. accepts cells now (multiple boards)
    
    % 3 p.i.n.a.p.
    % present is not a prediction (anymore)
    % starting from a step earlier, we forget a s supposition.
    % we don't suppose that future will be in general like the present.
    
    % 4 stochasticity and infinite values
    % stochasticy vector s_rule added, helps to disentangle unknown from impossible.
    % infinite values used in r_rule as stochastic values
    
    %% diagram
    %{
        1       PREDICTION
    V   1.1     learn (key,rule) pairs, learn stocasticity
        1.2     learn the effect of actions causally
    
        2.      TRANSFER & GENERALISATION
        2.1     all stays the same unless otherwise specified (simplest explanation)
        2.2     [1,1] is a combination of [1,0] and [0,1]
    %}
    
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
        k_rule;         ... prediction keys
        s_rule;         ... prediction stocasticity
        r_rule;         ... prediction rule
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
            obj.r_rule  = {};
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