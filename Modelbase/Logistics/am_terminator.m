classdef am_terminator < handle
  %  Terminates incoming entities.
  %  Outputs total number of incoming entities.
  %% Ports
  %  inputs:
  %    in       incoming value
  %  outputs:
  %    n        total number of arrived entities
  %% States
  %  s:        running
  %  n:        total number of arrived entities
  %  E:        last incoming entity (for debugging purposes)
  %% System Parameters
  %  name:               object name
  %  countyEmptyInputs:  flag to enable counting of empty input events
  %  tau:                input delay
  %  debug:              flag to enable debug information

  properties
    s
    n
    E
    countyEmptyInputs
    name
    tau
    debug
  end

  methods
    function obj = am_terminator(name, countyEmptyInputs, tau, debug)
      obj.name = name;
      obj.s = "running";
      obj.n = 0;
      obj.countyEmptyInputs = countyEmptyInputs;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta,", obj.name)
        showState(obj);
      end

      if ~isempty(x) && isfield(x,"in")
        if ~isempty(x.in)
          obj.n = obj.n + 1;
          obj.E = x.in;
        elseif obj.countyEmptyInputs
          obj.n = obj.n + 1;
        end
      end

      if obj.debug
        fprintf("%-8s leaving delta,", obj.name)
        showState(obj);
      end
    end

    function y=lambda(obj,e,x)
      y=[];
      if ~isempty(x) && isfield(x,"in")
        if  ~isempty(x.in)
          y.n = obj.n + 1;
        elseif obj.countyEmptyInputs
          y.n = obj.n + 1;
        end
      end

      if obj.debug
        fprintf("%-8s lambda\n", obj.name)
        showInput(obj, x)
        showOutput(obj, y)
      end
    end

    function t = ta(obj)
      t = [Inf,0];
    end

    %---------------------------------------------------------------
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s n=%s E=%s\n", obj.s, ...
        getDescription(obj.n), getDescription(obj.E));
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
