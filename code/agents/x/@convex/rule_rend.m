
% rend = CONVEX.RULE_REND(pred,past)
% render the prediction

%% warnings

%% function
function rend = rule_rend(obj,pred,past)
    n_memory = obj.options.n_memory;
    outs = [false(n_memory,1) , past , ~past , true(n_memory,1)];
    rend = double(pred);
    rend(~pred) = nan;
    rend = rend .* outs;
    rend = nanmean(rend,2);
end
