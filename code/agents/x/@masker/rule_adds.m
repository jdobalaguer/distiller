
% add a new rule to mend the prediction
function rule_adds(obj)
    keys = obj.past;
    rule = nan(obj.options.n_memory,1);
    rule(obj.errr) = obj.pres(obj.errr);
    obj.k_rule{end+1} = keys;
    obj.v_rule{end+1} = rule;
end
