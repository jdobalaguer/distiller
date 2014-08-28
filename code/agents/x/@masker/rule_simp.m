
% transform rules to make them more simple and general
function rule_simp(obj)

    % just checking (yn)
    assert(~any(all(isnan(cell2mat(obj.r_rule)) | isinf(cell2mat(obj.r_rule)))),'masker: rule_simp: error. stupid rules');

end
