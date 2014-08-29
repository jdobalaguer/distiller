
% set past and present values
function board_set(obj,status,action)
    obj.past = obj.pres;
    obj.pres = [status(:) ; action(:)];
end
