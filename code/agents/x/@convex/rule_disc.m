
% CONVEX.RULE_DISC()
% discard candidate functions from previous rules

%% warnings

%% function
function rule_disc(obj)
    n_rule = length(obj.rule);

    for i_rule = 1:n_rule
        past = obj.past;
        keys = obj.keys{i_rule};
        rule = obj.rule{i_rule};
        
        if all(keys(:) == past(:))
            obj.board_print(sprintf('mend %d before - ',i_rule),keys,rule);
            

            % CHANGE YOUR RULE HERE
            

            obj.board_print(sprintf('mend %d after  - ',i_rule),keys,rule);
        end
    end
end
