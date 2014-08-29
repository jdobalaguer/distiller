
% mend previous rules to correct for wrong knowledge
function rule_mend(obj)
    rules_to_mend = obj.maps(obj.errr)';
    rules_to_mend(isnan(rules_to_mend)) = [];
    rules_to_mend = unique(rules_to_mend);
    
    for i_rule = rules_to_mend
        keys = obj.k_rule{i_rule};
        stoc = obj.s_rule{i_rule};
        rule = obj.r_rule{i_rule};
        
        errr = (obj.errr);
        maps = (obj.maps == i_rule);
        mask = (errr & maps);
        
        obj.board_print({sprintf('mend stoc %d before',i_rule),sprintf('mend rule %d before',i_rule)}, ...
                        {stoc                                 ,rule                                 });
        stoc(mask) = 0;
        rule(mask) = inf;
        obj.board_print({sprintf('mend stoc %d after ',i_rule),sprintf('mend rule %d after ',i_rule)}, ...
                        {stoc                                 ,rule                                 });
        
        obj.errr = (errr & ~maps);
        obj.k_rule{i_rule} = keys;
        obj.s_rule{i_rule} = stoc;
        obj.r_rule{i_rule} = rule;
    end

    if ~isempty(rules_to_mend)
        % predict again
        pred1 = obj.pred();
        obj.rule_pred();
        pred2 = obj.pred();
        
        % assert
        assert(all(isequalni(pred1,pred2)),'masker: rule_mend: error.');
    end
end
