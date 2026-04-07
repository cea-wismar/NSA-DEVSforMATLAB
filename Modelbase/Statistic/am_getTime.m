classdef am_getTime < handle
%% Description
%  outputs current time, when a "true" event arrives
%% Ports
%  inputs: 
%    trigger   true -> outputs current time
%  outputs: 
%    out      current time
%% States
%  s:     running
%% System Parameters
%  name:  object name
%  tau:   input delay
%  debug: flag to enable debug information

  properties
    s
    name
    tau
    debug
  end
  
  methods
    function obj = am_getTime(name, tau, debug)
      obj.name = name;
      obj.s = "running";
      obj.tau = tau;
      obj.debug = debug;
    end
    
    function delta(obj,e,x)
      % empty
    end
       
    function y = lambda(obj,e,x)
      if ~isempty(x) && isfield(x, "trigger") && x.trigger
        y.out = get_time();
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