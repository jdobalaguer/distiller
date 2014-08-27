
% input interface for the agent
function step(obj, status, reward, terminal, action)
    obj.board_set(status,action);   ... set status, action
    if ~terminal
        obj.rule_pred();            ... prediction
        obj.rule_errr();            ... error
        if any(obj.errr)
            obj.rule_mend();        ... mend previous knowledge.
            obj.rule_adds();        ... add new knowledge/rule. set order.
            obj.rule_dels();        ... look for exceptions. remove episodic memory?
            obj.rule_simp();        ... simplify rules (compositions)
                                    ... 
        end
    end
end

