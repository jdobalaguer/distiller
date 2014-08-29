
% CONVEX.STEP()
% input interface for the agent

%% warnings
%#ok<*INUSL>

%% function
function step(obj, status, reward, terminal, action)
    obj.board_set(status,action);   ... set status, action
    if ~terminal
        obj.rule_asse();            ... assert
        obj.rule_adds();            ... add new rule
        obj.rule_pred();            ... prediction
        obj.rule_errr();            ... error
        obj.rule_disc();            ... discard
    end
end

