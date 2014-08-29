
% CONVEX.RULE_ERRR()
% calculate the error mask between present and prediction

%% warnings

%% function
function rule_errr(obj)
    n_memory = obj.options.n_memory;

    pres = nan(n_memory,1);
    pres(~obj.pred(:,1) & ~obj.pred(:,2)) = Inf; % unpredictable
    pres( obj.pred(:,1) & ~obj.pred(:,2)) = 0;   % definitely 0
    pres(~obj.pred(:,1) &  obj.pred(:,2)) = 1;   % definitely 1
    pres( obj.pred(:,1) &  obj.pred(:,2)) = NaN; % no clue
    
    obj.errr = (obj.pres ~= pres);
    obj.errr(isinf(pres)) = false;
    
    obj.board_print('errr',obj.errr);
end
