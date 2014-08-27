
classdef game < matlab.mixin.Copyable % handle + copyable
    
    %% PROPERTY
    properties
        options
        status
        reward
        terminal
        figure
        axis
    end
    
    %% WARNING
    %#ok<*CPROP,*MANU>
    
    %% METHOD
    methods
        function obj = game(options)
            % default
            jb('options ¬ options : struct()');
            options = default(options);
            % initialize
            obj.options = options;
            obj.initialize();
        end
        
        %% initalize
        function initialize(obj)
            obj.status   = false(obj.options.size); obj.status(1,:) = true;
            obj.reward   = 0;
            obj.terminal = true;
        end
        
        %% step
        function [status,reward,terminal] = step(obj,actions)
            % assert
            n_action = obj.options.size(2);
            assert(all(size(actions)==[1,n_action]),'game: error. action wrong size');
            
            status   = obj.status;
            reward   = 0;
            terminal = false;
            
            % get rows for each action
            rows = nan(1,n_action);
            for action = 1:n_action
                rows(action) = find(obj.status(:,action),1,'last');
            end
            
            % board full (restart)
            if any(rows == obj.options.size(1))
                obj.initialize();
                status   = obj.status;
                terminal = obj.terminal;
                actions  = false(1,n_action);
            end
            
            % apply actions
            for action = find(actions)
                row    = rows(action);
                
                % action violation (row full)
                if row == obj.options.size(1)
                    status = obj.status;
                    terminal = true;
                    break;
                end
                
                % set token
                status(row+1,action) = true; 
            end
            
            % save state and terminal
            obj.status      = status;
            obj.reward      = reward;
            obj.terminal    = terminal;
        end
        
        %% figure
        function figure_open(obj)
            if isempty(obj.figure)
                obj.figure = figure();
                set(obj.figure,'NumberTitle','off');
                set(obj.figure,'Color',[0.5,0.5,0.5]);
                set(obj.figure,'ToolBar','none');
                set(obj.figure,'CloseRequestFcn',@obj.figure_close);
                obj.axis   = get(obj.figure,'Children');
                set(obj.axis,  'Box','off');
                set(obj.axis,  'CLimMode','manual');
                set(obj.axis,  'CLim',[0,1]);
                set(obj.axis,  'Color',[0.5,0.5,0.5]);
                set(obj.axis,  'XTickLabelMode','manual');
                set(obj.axis,  'XTickLabel',{});
                set(obj.axis,  'XTick',[]);
                set(obj.axis,  'XColor',[0.5,0.5,0.5]);
                set(obj.axis,  'YTickLabelMode','manual');
                set(obj.axis,  'YTickLabel',{});
                set(obj.axis,  'YTick',[]);
                set(obj.axis,  'YColor',[0.5,0.5,0.5]);
            end
        end
        function figure_close(obj,gcbf,~)
            delete(gcbf);
            obj.figure = [];
        end
        function figure_plot(obj)
            image(obj.status);
            colormap(obj.figure,[0,0,0;1,1,1]);
        end
        function figure_refresh(obj)
            figure(obj.figure);
        end
        
        %% p-methods
        function print(obj)
            cprintf([1,0,0],'game : \n');
            disp(obj.status);
        end
        
        function plot(obj)
            obj.figure_open();
            obj.figure_plot();
            obj.figure_refresh();
        end
        
        function pause(obj)
            pause(1);
        end
    end
end

