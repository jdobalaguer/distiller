
% print board
function board_print(obj,text,present)

    % assert and default
    assert(~xor(iscell(text),iscell(present)),'board_print: error. wrong input');
    if ~iscell(text),    text    = {text};    end
    if ~iscell(present), present = {present}; end
    assert(length(text)==length(present), 'board_print: error. different lengths');
    
    % parameters
    d      = 10;
    
    % variables
    n      = length(text);
    l      = nan(1,n);
    status = cell(1,n);
    action = cell(1,n);
    
    % set strings
    for i = 1:n
        text{i}   = [text{i},':'];
        board     = present{i};
        status{i} = num2str(reshape(board(1:obj.options.n_status),obj.options.size));
        action{i} = num2str(board(end+1-obj.options.n_action:end)');
        l(i)      = max([size(text{i},2) , size(status{i},2) , size(action{i},2)]);
    end
    
    % expand strings
    for i = 1:n
        str = text{i};   str(:,end+1:l(i)+d) = ' '; text{i}   = str;
        str = status{i}; str(:,end+1:l(i)+d) = ' '; status{i} = str;
        str = action{i}; str(:,end+1:l(i)+d) = ' '; action{i} = str;
    end

    % concat strings
    text   = cell2mat(text);
    status = cell2mat(status);
    action = cell2mat(action);
    
    % print strings
    cprintf([0,1,0],[text,'\n']);
    for i = 1:size(status,1)
        fprintf([status(i,:),'\n']);
    end
    cprintf('*black',[action,'\n']);
    fprintf('\n');
    
end