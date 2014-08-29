
% CONVEX.RULE_ASSE()
% checks if rules are healthy

%% warnings

%% function
function rule_asse(obj)

    % same number of keys and rules
    assert(length(obj.keys) == length(obj.rule), 'convex: rule_asse: different number of keys and rules.');
    
    % no rules being all nans
    if ~isempty(obj.rule),
        assert(all(any(cellfun(@(x) any(x(:)),obj.rule))), 'convex: rule_asse: error. empty rule exists');
    end
    
end