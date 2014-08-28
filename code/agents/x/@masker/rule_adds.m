
% add a new rule to mend the prediction
function rule_adds(obj)
    if ~any(obj.errr), return; end
    
    keys = obj.past;
    stoc = nan(size(obj.past));
    rule = nan(obj.options.n_memory,1);
    rule(obj.errr) = obj.pres(obj.errr);
    obj.k_rule{end+1} = keys;
    obj.s_rule{end+1} = stoc;
    obj.r_rule{end+1} = rule;
    obj.board_print({sprintf('adds %d keys',length(obj.k_rule)),sprintf('adds %d stoc',length(obj.s_rule)),sprintf('adds %d rule',length(obj.r_rule))},...
                    {keys                                      ,stoc                                      ,rule                                      });
end
