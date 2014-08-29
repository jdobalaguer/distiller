
% print board
function board_print(obj,texts,boards)

    % assert and default
    assert(~xor(iscell(texts),iscell(boards)),'board_print: error. wrong input');
    if ~iscell(texts),  texts    = {texts};    end
    if ~iscell(boards), boards = {boards}; end
    assert(length(texts)==length(boards), 'board_print: error. different lengths');
    
    % parameters
    d      = 10;
    
    % variables
    n      = length(texts);
    l      = nan(1,n);
    status = cell(1,n);
    action = cell(1,n);
    
    % set strings
    for i = 1:n
        texts{i}   = [texts{i},':'];
        board     = boards{i};
        status{i} = num2str(reshape(board(1:obj.options.n_status),obj.options.size));
        action{i} = num2str(board(end+1-obj.options.n_action:end)');
        l(i)      = max([size(texts{i},2) , size(status{i},2) , size(action{i},2)]);
    end
    
    % expand strings
    for i = 1:n
        str = texts{i};   str(:,end+1:l(i)+d) = ' '; texts{i}   = str;
        str = status{i}; str(:,end+1:l(i)+d) = ' '; status{i} = str;
        str = action{i}; str(:,end+1:l(i)+d) = ' '; action{i} = str;
    end

    % concat strings
    texts   = cell2mat(texts);
    status = cell2mat(status);
    action = cell2mat(action);
    
    % print strings
    cprintf([0,1,0],[texts,'\n']);
    for i = 1:size(status,1)
        fprintf([status(i,:),'\n']);
    end
    cprintf('*black',[action,'\n']);
    fprintf('\n');
    
end