classdef am_const < handle
  %% Description
  %  Sends constant output at given (usually initial) time.
  %% Ports
  %  inputs: none
  %  outputs:
  %    out   given value
  %% States
  %  s:   running/ready
  %% System Parameters
  %  name:     object name
  %  value:    constant value
  %  sendTime: time, when value is sent (usually [0,1])
  %  debug:    flag to enable debug information
  properties
    s
    name
    value
    sendTime
    debug
  end

  methods
    function obj = am_const(name, value, sendTime, debug)
      obj.s ="running";
      obj.name = name;
      obj.value = value;
      obj.sendTime = sendTime;
      obj.debug = debug;
    end

    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj)
      end

      obj.s = "ready";
      
      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
    end

    function y = lambda(obj,e,x)
      y.out = obj.value;

      if obj.debug
        fprintf("%-8s lambda\n", obj.name)
        showOutput(obj, y)
      end
    end

    function t = ta(obj)
      if obj.s == "running"
        t = obj.sendTime;
      else
        t = [inf, 0];
      end
    end

    %---------------------------------------------------------------
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s\n", obj.s);
    end

    function showOutput(obj, y)
      % debug function, prints current output
      fprintf("  output: %s\n", getDescription(y))
    end

  end
end
