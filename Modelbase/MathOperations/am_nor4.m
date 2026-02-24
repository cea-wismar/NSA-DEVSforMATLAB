classdef am_nor4 < handle
  %% Description
  %  logical nor function of four inputs
  %% Ports
  %  inputs:
  %    in1, in2, in3, in4 incoming values
  %  outputs:
  %    out      nor of input values
  %% States
  %  s:         init/running
  %  i1/2/3/4:  stored input values
  %  o:         last output value
  %% System Parameters
  %  name:  object name
  %  i0:    initial values of input states
  %  debug: flag to enable debug information
  %  tau:   input delay

  properties
    s
    i1
    i2
    i3
    i4
    o
    name
    i0
    debug
    tau
  end

  methods
    function obj = am_nor4(name, i0, tau, debug)
      obj.s = "init";
      obj.i0 = i0;
      obj.i1 = i0;
      obj.i2 = i0;
      obj.i3 = i0;
      obj.i4 = i0;
      obj.o = ~i0;
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

      if isfield(x, "in1") && ~isempty(x.in1)
        obj.i1 = x.in1;
      end
      if isfield(x, "in2") && ~isempty(x.in2)
        obj.i2 = x.in2;
      end
      if isfield(x, "in3") && ~isempty(x.in3)
        obj.i3 = x.in3;
      end
      if isfield(x, "in4") && ~isempty(x.in4)
        obj.i4 = x.in4;
      end
      obj.o = ~(obj.i1 || obj.i2 || obj.i3 || obj.i4);

      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end
    end

    function y = lambda(obj,e,x)
      s1 = obj.i1;
      s2 = obj.i2;
      s3 = obj.i3;
      s4 = obj.i4;
      if isfield(x, "in1") && ~isempty(x.in1)
        s1 = x.in1;
      end
      if isfield(x, "in2") && ~isempty(x.in2)
        s2 = x.in2;
      end
      if isfield(x, "in3") && ~isempty(x.in3)
        s3 = x.in3;
      end
      if isfield(x, "in4") && ~isempty(x.in4)
        s4 = x.in4;
      end

      oNew = ~(s1 || s2 || s3 || s4);
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
      fprintf("  phase=%s i1=%s i2=%s i3=%s i4=%s\n", obj.s, ...
        getDescription(obj.i1), getDescription(obj.i2), ...
        getDescription(obj.i3), getDescription(obj.i4));
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
