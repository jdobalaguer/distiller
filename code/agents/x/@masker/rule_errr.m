
% calculate the error mask between present and prediction
function rule_errr(obj)
    obj.errr = ~isequalni(obj.pres,obj.pred) | isnan(obj.pred);
    obj.board_print('errr',obj.errr);
end
