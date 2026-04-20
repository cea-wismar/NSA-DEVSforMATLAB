classdef am_enabledgenerator < handle
  %% Description
  %  generates entities with fixed interarrival times and increasing id's
  %  stops, while enable input = false
  %  enables becomes true -> waiting time tG begins at 0
  %% Ports
  %  inputs:
  %    enable   true -> generator runs
  %  outputs:
  %    out      generated entities
  %% States
  %  s:     running|stopped
  %  id:    number of next entity generated
  %  sigma: time until next state change
  %  epsilon: accuracy of real number comparisons
  %% System Parameters
  %  name:  object name
  %  tG:    time interval between new entities
  %  n0:    id of first entity
  %  nG:    total number of entities created
  %  tD:    delay between entities, when tG = 0
  %  tau:   input delay
  %  debug: flag to enable debug information

  properties
    s
    id
    sigma
    epsilon
    name
    tG
    n0
    nG
    tD
    tau
    debug
  end

  methods
    function obj = am_enabledgenerator(name, tG, n0, nG, tD, tau, debug)
      obj.name = name;
      obj.tG = tG;
      obj.n0 = n0;
      obj.nG = nG;
      obj.s = "running";
      obj.id = n0;
      obj.sigma = tG;
      obj.epsilon = get_epsilon();
      obj.tD = tD;
      obj.tau = tau;
      obj.debug = debug;
    end

    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj)
      end

      if ~isempty(x) && isfield(x, "enable")
        % external event
        if ~isempty(x.enable) && ~x.enable && obj.s == "running"
          % enabled = false
          obj.s = "stopped";
          obj.sigma = obj.sigma - e(1);
          if abs(obj.sigma) <= obj.epsilon      % confluent
            obj.sigma = obj.tG;
            obj.id = obj.id + 1;
          end
        elseif ~isempty(x.enable) && x.enable
          % enabled = true
          if obj.s == "stopped"
            obj.s = "running";
          else
            obj.sigma = obj.sigma - e(1);
          end
          if abs(obj.sigma) <= obj.epsilon      % confluent
            obj.sigma = obj.tG;
            obj.id = obj.id + 1;
          end
        elseif isempty(x.enable)                % enabled = []
          % do nothing
        end

      elseif abs(e(1) - obj.sigma) <= obj.epsilon
        % internal event
        obj.sigma = obj.tG;
        obj.id = obj.id + 1;
      end

      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj)
      end

    end

    function y = lambda(obj,e,x)
      if obj.s == "running" && abs(e(1) - obj.sigma) <= obj.epsilon
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
      if obj.id - obj.n0 < obj.nG && obj.s == "running"
        if obj.tG == 0
          t = obj.tD;
        else
          t = [obj.sigma, 0];
        end
      else
        t = [inf, 0];
      end
    end

    %---------------------------------------------------------------
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s id=%s sigma=%s\n", obj.s, ...
        getDescription(obj.id), getDescription(obj.sigma));
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