
classdef convex < matlab.mixin.Copyable % handle + copyable
    % CONVEX()
    % convex model
    
    %% novelties
    
    % 1 candidate representation of rules
    % rules are now represented as matrices [0,s,d,1]
    % each column corresponding to a possible function
    % (more functions would be required if using more times)
    % stochasticity vector is not required anymore.
    % maps new representation, allowing overlapping rules (currently useless) and counter of candidates
    
    % 2 convexity
    % learning convexity of spaces.
    % game transformed to allow for backward actions
    
    % 3 structure
    % creating a default assert
    % now adding rules before predicting
    
    % 4 errr
    % obj.errr keeps comparing prediction and present
    % this now doesnt mean that a particular rule is wrong
    % all rules with matching keys need to be updated
    
    %% diagram
    %{
        0       COMPRESSION
        1       PREDICTION
        2       TRANSFER & GENERALISATION
    %}
    
    %% properties
    properties
        % options
        options
        functns
        
        % time
        past;           ... time past
        pres;           ... time present
        
        maps;           ... prediction index
        pred;           ... prediction value
        errr;           ... prediction error
            
        % rule storage
        keys;         ... prediction keys
        rule;         ... prediction rule [0,s,d,1]
    end
    
    methods
        %% constructor
        function obj = convex(options)
            obj.options = options;
            obj.functns = jb_binarytable(2);
            
            obj.past    =   nan(options.n_memory,1); % view
            obj.pres    =   nan(options.n_memory,1);
            
            obj.maps    =   nan(options.n_memory,1); % pred
            obj.pred    =   nan(options.n_memory,1);
            obj.errr    = false(options.n_memory,1);
            
            obj.keys    = {};
            obj.rule    = {};
        end
     
        %% methods
        step(obj, status, reward, terminal, action);
        
        board_set(obj,status,action);   ... set past and present values
        board_print(obj,texts,boards);    ... print board
        
        rule_asse(obj);                 ... checks if rules are healthy
        rule_adds(obj);                 ... add a new rule to mend the prediction
        rule_pred(obj);                 ... predict the present from the past (using stored rules)
        rule_errr(obj);                 ... calculate the error mask between present and prediction
        rule_disc(obj);                 ... discard candidate functions from previous rules
        rule_print(obj,text,keys,rule); ... print rule
    end
end