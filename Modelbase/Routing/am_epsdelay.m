classdef am_epsdelay < handle
%% Description
%  delays its input by an infinitesimal amount
%% Ports
%  inputs: 
%    in       incoming value
%  outputs: 
%    out      outgoing value
%% States
%  s:   running
%% System Parameters
%  name:  object name
%  tau:   infinitesimal delay
%  debug: flag to enable debug information
    
  properties
    s
    name
    debug
    tau
  end
  
  methods
    function obj = am_epsdelay(name, tau, debug)
      obj.s ="running"; 
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end
          
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s delta in/out\n", obj.name)
      end      
    end
                  
    function y = lambda(obj,e,x)
      y.out = x.in;
        
      if obj.debug
        fprintf("%-8s lambda\n", obj.name)
        showInput(obj, x)
        showOutput(obj, y)
      end
    end
    
    function t = ta(obj)
      t = [inf, 0];
    end
   
    %-------------------------------------------------------
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
