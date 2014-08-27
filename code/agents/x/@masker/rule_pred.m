
% predict the present from the past (using stored rules)
function rule_pred(obj)
    assert(length(obj.k_rule) == length(obj.v_rule), 'masker: rule_pred: error 1.');
    maps = nan(obj.options.n_memory,1);
    pred = nan(obj.options.n_memory,1);
    n_rule = length(obj.k_rule);
    for i_rule = 1:n_rule
        keys = obj.k_rule{i_rule};
        rule = obj.v_rule{i_rule};
        k_mask = ~isnan(keys);
        v_mask = ~isnan(rule);
        p_mask = ~isnan(pred);
        if all(obj.past(k_mask) == keys(k_mask))
            assert(all(pred(v_mask&p_mask) == rule(v_mask&p_mask)), 'masker: rule_pred: error 2.');
            maps(v_mask) = i_rule;
            pred(v_mask) = rule(v_mask);
        end
    end
    obj.maps = maps;
    obj.pred = pred;
end
