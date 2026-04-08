classdef am_triggeredgenerator < handle
%% Description
%  generates entities with increasing id's, when "true" events arrive
%% Ports
%  inputs: 
%    trigger   true -> new entity is generated
%  outputs: 
%    out      generated entities
%% States
%  s:     running
%  id:    number of next entity generated
%% System Parameters
%  name:  object name
%  n0:    id of first entity
%  tau:   input delay
%  debug: flag to enable debug information

  properties
    s
    id
    name
    n0
    tau
    debug
  end
  
  methods
    function obj = am_triggeredgenerator(name, n0, tau, debug)
      obj.name = name;
      obj.n0 = n0;
      obj.s = "running";
      obj.id = n0;
      obj.tau = tau;
      obj.debug = debug;
    end
    
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj)
      end

      if ~isempty(x) && isfield(x, "trigger") && ~isempty(x.trigger) && x.trigger
        obj.id = obj.id + 1;
      end

      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
    end
       
    function y = lambda(obj,e,x)
      if ~isempty(x) && isfield(x, "trigger") && ~isempty(x.trigger) && x.trigger
        y.out = obj.id;
      else
        y=[];
      end
   
      if obj.debug
        fprintf("%-8s lambda\n", obj.name)
        showInput(obj, x)
        showOutput(obj, y)
      end   
    end
    
    function t = ta(obj)
      t = [inf, 0];
    end
    
    %---------------------------------------------------------------------
    function showState(obj)
      % debug function, prints current state
      fprintf("  id=%2d\n", obj.id);
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