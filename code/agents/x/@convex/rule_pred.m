
% CONVEX.RULE_PRED()
% predict the present from the past (using stored rules)

%% warnings

%% function
function rule_pred(obj)
    n_memory = obj.options.n_memory;
    n_rule   = length(obj.keys);
    
    maps = nan( n_memory,n_rule);
    pred = true(n_memory,4);

    past = obj.past;
    pres = obj.pres;
    
    obj.board_print({'past', 'pres'},...
                    { past ,  pres });
    
    for i_rule = 1:n_rule
        keys = obj.keys{i_rule};
        rule = obj.rule{i_rule};
        
        if obj.key_match(past,keys)
            % set maps
            maps(:,i_rule) = sum(rule == false,2);
            
            % prediction is true until proved the opposite (this allows to specify both prediction and confidence at once)
            pred = pred & rule;
        end
    end
    
    obj.rule_print('pred',past,pred);
    obj.maps = maps;
    obj.pred = pred;
    
    % render the prediction
    rend = obj.rule_rend(rule,past);
    obj.board_print('rend',rend);
end
