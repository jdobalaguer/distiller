
% predict the present from the past (using stored rules)
function rule_pred(obj)
    assert(length(obj.k_rule) == length(obj.r_rule), 'masker: rule_pred: error 1.');
    maps = nan(obj.options.n_memory,1);
    pred = nan(obj.options.n_memory,1);
    n_rule = length(obj.k_rule);
    for i_rule = 1:n_rule
        keys = obj.k_rule{i_rule};
        stoc = obj.s_rule{i_rule};
        rule = obj.r_rule{i_rule};
%         k_mask = ~isnan(keys);
        s_mask = (stoc == 0);
        r_mask = ~isnan(rule);
%         p_mask = ~isnan(pred) & ~isinf(pred);
        assert(all(rule(s_mask) == Inf), 'masker: rule_pred: error 2.');
        if all(isequalni(obj.past,keys))
            assert(all(isequalni(pred,rule)), 'masker: rule_pred: error 3.');
            maps(r_mask) = i_rule;
            pred(r_mask) = rule(r_mask);
%             keys
%             stoc
%             rule
%             pred
%             k_mask
%             s_mask
%             r_mask
%             p_mask
        end
    end
    obj.maps = maps;
    obj.pred = pred;
    
    obj.board_print({'past', 'pres',   'pred',  'maps'  },...
                    {obj.past,obj.pres,obj.pred,obj.maps});
end
