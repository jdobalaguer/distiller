
% calculate the error mask between present and prediction
function rule_errr(obj)
    obj.errr = (obj.pres ~= obj.pred);
end
