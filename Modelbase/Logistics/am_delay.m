classdef am_delay < handle
  %% Description
  %  Delays the input entities by a constant amount.
  %% Ports
  %  inputs:
  %    in    incoming entities
  %  outputs:
  %    out   delayed entities
  %% States
  %  s:  running
  %  E:  waiting input values, E(i).x = value, E(i).e = remaining waiting time
  %% System Parameters
  %  name:  object name
  %  dt:    delay time
  %  tau:   infinitesimal delay
  %  debug: flag to enable debug information

  properties
    s
    E
    dt
    name
    tau
    debug
  end

  methods
    function obj = am_delay(name, dt, tau, debug)
      obj.s = "running";
      obj.E = [];
      obj.name = name;
      if isscalar(dt)      % add eps component, if necesssary
        obj.dt = [dt, 0];
      else
        obj.dt = dt;
      end
      obj.tau = tau;
      obj.debug = debug;
    end

    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj);
      end

      % erase entity that has been output already
      if ~isempty(obj.E) && obj.E(1).e(1) <= e(1) + get_epsilon()
        obj.E = obj.E(2:end);
      end

      % adjust waiting times
      if ~isempty(obj.E)
        for i=1:length(obj.E)
          obj.E(i).e = obj.E(i).e - e;
          obj.E(i).e(2) = 0;           % use st(t)
        end
      end

      % append new element
      if isfield(x,"in")
        value.x = x.in;
        value.e = obj.dt;
        obj.E = [obj.E, value];
      end

      if obj.debug
        fprintf("%-8s leaving  delta\n", obj.name)
        showState(obj);
      end
    end

    function y = lambda(obj,e,x)
      if ~isempty(obj.E) && obj.E(1).e(1) <= e(1) + get_epsilon()
        y.out = obj.E(1).x;
      else
        y = [];
      end

      if obj.debug
        fprintf("%-8s lambda\n", obj.name)
        showInput(obj, x)
        showOutput(obj, y)
      end
    end

    function t = ta(obj)
      if isempty(obj.E)
        t = [Inf, 0];
      else
        t = obj.E(1).e;
      end
    end

    %-------------------------------------------------------
    function showState(obj)
      % debug function, prints current state
      fprintf("  E=%s\n", getDescription(obj.E));
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
