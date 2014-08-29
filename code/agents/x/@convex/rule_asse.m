
% checks if rules are healthy
function rule_asse(obj)

    % same number of keys and rules
    assert(length(obj.keys) == length(obj.rule), 'convex: rule_asse: different number of keys and rules.');
    
    % no rules being all nans
    assert(~any(cellfun(@(x) all(isnan(x(:))),obj.rule)), 'convex: rule_asse: error. rule with all nans exist');
    
end