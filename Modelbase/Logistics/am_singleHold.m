classdef am_singleHold < handle
  % holds an entity until the cond input is true.
  % Only one entity can be hold at a time.
  % If an entity leaves and a new entity enters at the same time, the hold
  % entity is output and the new entity is hold.
  % Arriving entities are dropped if the block is already occupied.
  % Inputs:
  %     in    incoming entity
  %     cond  true -> hold entity is released
  % Outputs:
  %     out   outgoing entity
  %     drop  true if incoming entity is dropped (else no output)
  % States:
  %   E     hold entity
  %   cond  state of condition input
  % System Parameters:
  %   name   object name
  %   tau    input delay
  %   debug  flag to enable debug information

  properties
    E
    cond
    name
    tau
    debug
  end

  methods
    function obj = am_singleHold(name, tau, debug)
      obj.E   = [];
      obj.cond = false;
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end
    
    function delta(obj,e,x) %#ok<*INUSD>
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj);
      end

      [in, condIn] = getInput(obj, x);

      if ~isempty(condIn)
        obj.cond = condIn;
      end

      if ~obj.cond && isempty(obj.E) && ~isempty(in) 
        obj.E = in;             % incoming E is hold
      elseif obj.cond && ~isempty(obj.E) 
        if isempty(in)
          obj.E = [];           % delayed E has been output
        else
          obj.E = in;           % delayed E has been output, hold incoming E
        end
      end

      if obj.debug
        fprintf("%-8s leaving  delta\n", obj.name)
        showState(obj);
      end
    end
    
    function y = lambda(obj,e,x)
      y = [];     % necessary dummy value for no-op
      [in, condIn] = getInput(obj, x);
      if isempty(condIn)
        condIn = obj.cond;
      end

      if ~condIn && ~isempty(obj.E) && ~isempty(in)
        y.drop = true;         % drop incoming E
      elseif condIn && isempty(obj.E) && ~isempty(in)
        y.out = in;            % output incoming E        
      elseif condIn && ~isempty(obj.E) 
        y.out = obj.E;         % output hold E       
      end

      if obj.debug
        fprintf("%-8s lambda\n", obj.name)
        showInput(obj, x)
        showOutput(obj, y)
      end
    end
    
    function t = ta(obj) %#ok<*MANU>
      t = [Inf,0];
    end

    %----------------------------------------------------------------------
    function [in, condIn] = getInput(obj, x)
      % returns input values or value [], if there is no input at a port
      if isfield(x, "in")
        in = x.in;
      else
        in = [];
      end
      if isfield(x, "cond")
        condIn = x.cond;
      else
        condIn = [];
      end
    end

    function showState(obj)
      % debug function, prints current state
      fprintf("  E=%s, cond=%s\n", ...
        getDescription(obj.E), getDescription(obj.cond));
    end

    function showInput(obj, x)
      % debug function, prints current input
      fprintf("  input:  %s\n", getDescription(x))
    end

    function showOutput(obj, y)
      % debug function, prints current output
      fprintf("  output: %s\n", getDescription(y))
    end
  end
end
