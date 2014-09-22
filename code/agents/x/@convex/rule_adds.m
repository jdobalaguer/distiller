
% CONVEX.RULE_ADDS()
% add a new rule

%% warnings

%% function
function rule_adds(obj)
    ii_rule = cellfun(@obj.key_match,obj.keys,repmat({obj.past},size(obj.keys)));
    if ~any(ii_rule),
        i_rule = length(obj.keys)+1;
        keys = obj.key_gen(obj.past);
        rule = obj.rule_gen(obj.past,obj.pres);
        obj.keys{i_rule} = keys;
        obj.rule{i_rule} = rule;
        obj.rule_print(sprintf('adds %d -',i_rule),keys,rule);
    end
end
