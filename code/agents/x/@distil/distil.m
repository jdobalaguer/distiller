
classdef distil < matlab.mixin.Copyable % handle + copyable
    %% DISTIL()
    % distiller agent
    
    %% NOTE
    %{
    
    **PRELIMINARES
    aceptamos olvidarnos de :
      - en qué trial estamos (y de qué es un estado inicial)
      - de que hay dependencia directa con más de un trial de diferencia
      - del indeterminismo
      - numero finito de aciones
      - la interaccion agent/game se organiza eficientemente en un solo paso
      - la organización espacial a priori
    buscamos :
      - la transferencia de conocimiento
      - la destilación de información, bajo una forma expresable
      - el aprendizaje por reglas
      - la identificación de contextos sin señales externas
    
    **META
    la regla :
      board( action , row(action)+1 ) = 1;
    
    **MEDIOS
    los pasos :
      - buscar qué es específico del (state + action) ............... DONE
      - predecir (state + action) ................................... DONE
      - extraer información de cada predicción
      - transferir conocimiento de cada información
    
    %}
    
    %% OLD IDEAS
    
    % TODO: define a distance between experiences, using weights
    % TODO: find chunks that minimize chunk_distance + episodic_distance

    %% DIAGRAM
    %{
        1) memory: episodic memories
        2) rule:   overlapping consecuences
        3) match:  rule attention
        
    
    %}
    
    %% WARNING
    %#ok<*INUSD,*PROP,*INUSL,*NASGU>
    
    %% PROPERTY
    properties
        options
        
        past
        present
        
        memory
        rules
        matches
    end
    
    %% METHOD
    methods
        function obj = distil(options)
            % default options
            obj.options          = options;
            % matrices
            obj.present = nan(obj.options.n_memory,1);
            % dictionnaries
            obj.memory  = dict();
            obj.rules   = dict();
            obj.matches = dict();
        end
        
        %% step function
        function step(obj, status, reward, terminal, action)
            obj.present_set(obj.present_get(status,action));    % set present
            if ~terminal
                obj.rules(obj.past)   = obj.memory_rule();      % rule
                obj.matches(obj.past) = obj.match_matx();       % match
                obj.memory_add();                               % memory
                
                clc;
                fprintf('CYCLE \n');
                obj.print_board('past',obj.past);
                obj.print_board('memo',obj.memory_mean());
                obj.print_board('rule',obj.rules(obj.past));
                obj.print_board('pred',obj.prediction_get);
                obj.print_board('matx',obj.match_matx());
            end
        end
        
        %% present
        
        function present = present_get(obj,status,action)
            present  = [ status(:) ; action(:) ];
        end
        
        function present_set(obj,present)
            obj.past    = obj.present;
            obj.present = present;
        end
        
        %% memory
        
        function memory_add(obj)
            memory = obj.memory(obj.past);
            if isempty(memory), memory        = {obj.present};
            else                memory(end+1) = {obj.present};
            end
            obj.memory(obj.past) = memory;
        end
        
        function memory = memory_get(obj)
            memory = cell2mat(obj.memory(obj.past));
            if isempty(memory), memory = zeros(obj.options.n_memory,0); end
        end
        
        function memory = memory_mean(obj)
            memory = obj.memory_get();
            memory = mean(memory,2);
        end
        
        function mask = memory_mask(obj)
            memory  = obj.memory_get();
            past    = repmat(obj.past,1,size(memory,2));
            diff    = double(past - memory);    % temporal derivative to estimate action causality.
                                                % we should use a prediction, rather than the past.
            if isempty(diff),   mask = ones(obj.options.n_memory,1);
            else                mask    = all(logical(diff),2);
            end
        end
        
        function rule = memory_rule(obj)
            mask = obj.memory_mask();
            rule = obj.memory_mean();
            rule(~mask) = nan;
        end
        
        %% prediction
        
        function pred = prediction_get(obj)
            pred = obj.past;
            rule = obj.rules(obj.past);
            pred(~isnan(rule)) = rule(~isnan(rule));
        end
        
        %% match
        
        function matx = match_get(obj)
            rule = obj.rules(obj.past);
            keys = obj.rules.keys();
            vals = obj.rules.values();
            ii   = cellfun(@(x)isequaln(x,rule),vals);
            keys = keys(ii);
            vals = vals(ii);
            matx = cell2mat(keys');
        end
        
        function matx = match_mean(obj)
            matx = obj.match_get();
            matx = mean(matx,2);
        end
        
        function mask = match_mask(obj)
            matx = obj.match_get();
            mask = ~var(matx,[],2);
        end
        
        function matx = match_matx(obj)
            mask = obj.match_mask();
            matx = obj.match_mean();
            matx(~mask) = nan;
        end
        
        % next TODO : check for same mask different rule -- if yes we can delete the episodic memory
        % next TODO : compare masks between rules, minimize mask
        
        %% print
        function print_board(obj,text,present)
            cprintf([0,1,0],[text,': \n']);
            fprintf('status : \n');
            status = present(1:obj.options.n_status);
            status = reshape(status,obj.options.size);
            disp(status);
            fprintf('action : \n');
            action = present(end+1-obj.options.n_action:end);
            disp(action);
        end
        
        function print_all(obj)
            obj.print_board('past',         obj.past);
            obj.print_board('rule',         obj.rules(obj.past));
            obj.print_board('prediction',   obj.prediction_get(obj.rules(obj.past),obj.past));
            obj.print_board('present',      obj.present);
        end
    end
end
