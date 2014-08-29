
% CONVEX.RULE_ADDS()
% add a new rule

%% warnings

%% function
function rule_adds(obj)
    if ~any(obj.errr), return; end
    
    ii_rule = cellfun(@(k) all(k(:) == obj.past(:) , obj.keys);
    if ~any(ii_rule),
        i_rule = length(obj.keys+1);
        keys = obj.past;
        rule = true(obj.options.n_memory,4);
        obj.keys{i_rule} = keys;
        obj.rule{i_rule} = rule;
        
        obj.rule_print(sprintf('adds %d - ',i_rule),keys,rule);
    end
    
end
