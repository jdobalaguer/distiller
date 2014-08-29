
% CONVEX.BOARD_SET(status,action)
% set past and present values

%% warnings

%% function
function board_set(obj,status,action)
    obj.past = obj.pres;
    obj.pres = [status(:) ; action(:)];
end
