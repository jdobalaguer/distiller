
% rule = CONVEX.RULE_GEN(past,pres)
% generate a rule from the observation

%% warnings
%#ok<*INUSL>

%% function
function rule = rule_gen(obj,past,pres)
    assert(numel(past)==numel(pres),'convex.rule_gen: past and pres have different number of elements');
    warning('convex.rule_gen: TODO');
    rule = true(numel(past),4);
end
