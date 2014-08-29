
% CONVEX.RULE_PRED()
% predict the present from the past (using stored rules)

%% warnings

%% function
function rule_pred(obj)
    n_memory = obj.options.n_memory;
    n_rule   = length(obj.keys);
    
    maps = nan( n_memory,n_rule);
    pred = true(n_memory,2);
    
    for i_rule = 1:n_rule
        past = obj.past;
        keys = obj.keys{i_rule};
        rule = obj.rule{i_rule};
        if all(past(:) == keys(:))
            
            % get prediction from each function
            outs = false(n_memory,2);
            for i=1:n_memory,                 outs(i,1) = outs(i,1) | rule(i,1); end % zero
            for i=1:n_memory, j =  past(i)+1; outs(i,j) = outs(i,j) | rule(i,2); end % same
            for i=1:n_memory, j = ~past(i)+1; outs(i,j) = outs(i,j) | rule(i,2); end % diff
            for i=1:n_memory,                 outs(i,4) = outs(i,4) | rule(i,4); end % ones
            
            % set maps
            maps(:,i_rule) = sum(outs==false,2);
            
            % prediction is true until proved the opposite
            % (this allows to specify both prediction and confidence at once)
            pred = pred & outs;
            
        end
    end
    obj.maps = maps;
    obj.pred = pred;
    
    obj.board_print({'past', 'pres',   'pred',  'maps'  },...
                    {obj.past,obj.pres,obj.pred,obj.maps});
end
