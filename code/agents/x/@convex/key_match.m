
% match = CONVEX.KEY_MATCH(key,past)
% matching observation and key

%% warnings

%% function
function match = key_match(obj,key,past)
    past_key = obj.key_gen(past);
    match = all(past_key(key(:)));
end
