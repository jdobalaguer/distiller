
% print board
function board_print(obj,text,present)
    cprintf([0,1,0],[text,': \n']);
    fprintf('status : \n');
    status = present(1:obj.options.n_status);
    status = reshape(status,obj.options.size);
    disp(status);
    fprintf('action : \n');
    action = present(end+1-obj.options.n_action:end);
    disp(action);
end
