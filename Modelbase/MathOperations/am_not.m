classdef am_not < handle
  %% Description
  %  logical not gate
  %% Ports
  %  inputs:
  %    in     incoming value
  %  outputs:
  %    out    output value
  %% States
  %  s:   init/running
  %  in1: stored input value
  %  o:   last output value
  %% System Parameters
  %  name:  object name
  %  i0:    initial value of in state
  %  debug: flag to enable debug information
  %  tau:   infinitesimal delay

  properties
    s
    in1
    o
    name
    i0
    debug
    tau
  end

  methods
    function obj = am_not(name, i0, tau, debug)
      obj.s = "init";
      obj.i0 = i0;
      obj.in1 = i0;
      obj.o = i0;
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj)
      end

      obj.s = "running";

      if isfield(x, "in") && ~isempty(x.in)
        obj.in1 = x.in;
      end
      obj.o = ~obj.in1;

      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
    end

    function y = lambda(obj,e,x)
      s1 = obj.in1;
      if isfield(x, "in") && ~isempty(x.in)
        s1 = x.in;
      end

      oNew = ~s1;
      if oNew ~= obj.o || obj.s == "init"
        y.out = oNew;
      else
        y.out = [];
      end
     
      if obj.debug
        fprintf("%-8s lambda\n", obj.name)
        showInput(obj, x)
        showOutput(obj, y)
      end
    end

    function t = ta(obj)
      if obj.s == "init"
        t = obj.tau;
      else
        t = [inf, 0];
      end
    end

    %---------------------------------------------------------------
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s in1=%s o=%s\n", obj.s, ...
        getDescription(obj.in1), getDescription(obj.o));
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
