
% CONVEX.RULE_DISC()
% discard candidate functions from previous rules

%% warnings

%% function
function rule_disc(obj)
    n_memory = obj.options.n_memory;
    n_rule   = length(obj.rule);

    for i_rule = 1:n_rule
        past = obj.past;
        pres = obj.pres;
        keys = obj.keys{i_rule};
        rule = obj.rule{i_rule};
        
        if obj.key_match(past,keys)
            % print rule
            obj.rule_print(sprintf('mend %d before -',i_rule),keys,rule);
            
            % get prediction from each function
            says = repmat(pres,1,4);
            outs = [false(n_memory,1) , past , ~past , true(n_memory,1)];
            
            % discard candidates
            % is 0, discard candidates saying 1
            rule(says(:)==0 & outs(:)==1) = false;
            % is 1, discard candidates saying 0
            rule(says(:)==1 & outs(:)==0) = false;

            % print rule
            obj.rule_print(sprintf('mend %d after  -',i_rule),keys,rule);
            
            % save
            obj.rule{i_rule} = rule;
        end
    end
end
