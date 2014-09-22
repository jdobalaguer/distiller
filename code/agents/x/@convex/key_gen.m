
% key = CONVEX.KEY_GEN(past)
% generate a key from the observation

%% warnings
%#ok<*INUSL>

%% function
function key = key_gen(obj,past)
    key = false(numel(past),2);
    for i = 1:numel(past)
        key(i,past(i)+1) = true;
    end
end
