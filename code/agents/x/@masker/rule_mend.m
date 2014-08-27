
% mend previous rules to correct for wrong knowledge
function rule_mend(obj)
    rules_to_mend = obj.maps(obj.errr);
    rules_to_mend(isnan(rules_to_mend)) = [];
    rules_to_mend = unique(rules_to_mend);

    % predict again
    pred = obj.pred();
    obj.rule_pred();
    
    assert(all(isequaln(pred,obj.pred)),'masker: rule_mend: error.');
end
