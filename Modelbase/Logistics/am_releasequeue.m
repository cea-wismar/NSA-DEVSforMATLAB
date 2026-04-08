classdef am_releasequeue < handle
  %% Description
  %  FIFO queue with output of current queue length.
  %  Outputs selected entities through output outR, when a release control
  %  entity arrives at input rel.
  %  Type of the control entity:
  %    rel = {name, value} → entities with attribute name=value are released
  %    special name "queuePosition_" → releases entities at given queue position
  %    value > 0 → counts from front end, value < 0 → counts from back end
  %% Ports
  %  inputs:
  %    in   incoming entities
  %    bl   new blocking status at output
  %    rel  release control input
  %  outputs:
  %    out   outgoing entities
  %    outR  released entities
  %    nq    queue length
  %    noRel true, if no entities are released at rel input
  %% States
  %  phase: Queuing|Releasing
  %  phaseQ: EmptyFree|EmptyBlocked|QueuingFree|QueuingBlocked
  %  q: vector of queued entities
  %  qR: vector of entities to release
  %% System Parameters
  %  name:  object name
  %  useSingleElementBatch: flag with default = false, set it to true, when 
  %         expecting one or more entities at outR
  %  tD:    delay time of the QueuingFree state
  %  tau:   input delay
  %  debug: model debug level

  properties
    phase
    phaseQ
    q
    qR
    name
    useSingleElementBatch
    tD
    tau
    debug
  end

  methods
    function obj = am_releasequeue(name, useSingleElementBatch, tD, tau, debug)
      obj.phase = "Queuing";
      obj.phaseQ = "EmptyFree";
      obj.q = [];
      obj.qR = [];
      obj.name = name;
      obj.useSingleElementBatch = useSingleElementBatch;
      obj.tau = tau;
      obj.tD = tD;
      obj.debug = debug;
    end

    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj);
      end

      [bl, in, rel] = getInput(obj, x);

      if obj.phase == "Releasing"
        % assuming no input
        obj.qR = [];
        obj.phase = "Queuing";
      else
        switch obj.phaseQ
          case "EmptyFree"
            if ~isempty(bl) && bl && isempty(in)
              obj.phaseQ = "EmptyBlocked";
            elseif ~isempty(bl) && bl && ~isempty(in)
              obj.phaseQ = "QueuingBlocked";
              obj.q = [obj.q, in];
            elseif ~isempty(in)
              obj.phaseQ = "QueuingFree";
              obj.q = [obj.q, in];
            else
              % no entities, bl status remains
            end
          case "EmptyBlocked"
            if ~isempty(bl) && ~bl && isempty(in)
              obj.phaseQ = "EmptyFree";
            elseif ~isempty(bl) && ~bl && ~isempty(in)
              obj.phaseQ = "QueuingFree";
              obj.q = [obj.q, in];
            elseif ~isempty(in)
              obj.phaseQ = "QueuingBlocked";
              obj.q = [obj.q, in];
            else
              % no entities, bl status remains
            end
          case "QueuingFree"
            if isempty(x)     % internal event
              if (isscalar(obj.q))
                obj.phaseQ = "EmptyFree";
              else
                obj.phaseQ = "QueuingFree";
              end
              obj.q = obj.q(2:end);
            else             % confluent event
              if ~isempty(bl) && bl
                % blocking has precedence, no entity leaves!
                obj.phaseQ = "QueuingBlocked";
                obj.q = [obj.q, in];
              else
                obj.q = [obj.q(2:end), in];
                if isempty(obj.q)
                  obj.phaseQ = "EmptyFree";
                else
                  obj.phaseQ = "QueuingFree";
                end
              end
            end
          case "QueuingBlocked"
            obj.q = [obj.q, in];
            if ~bl
              obj.phaseQ = "QueuingFree";
            end
        end
        if ~isempty(rel)
          M = getMatchingEntities(obj, rel);
          if ~isempty(M)
            obj.qR = obj.q(M);
            obj.q(M) = [];
            obj.phase = "Releasing";
            % adapting phaseQ
            switch obj.phaseQ
              case "QueuingFree"
                if isempty(obj.q)
                  obj.phaseQ = "EmptyFree";
                end
              case "QueuingBlocked"
                if isempty(obj.q)
                  obj.phaseQ = "EmptyBlocked";
                end
            end
          end
        end
      end

      if obj.debug
        fprintf("%-8s leaving  delta\n", obj.name)
        showState(obj);
      end
    end

    function y = lambda(obj,e,x)
      y = [];     % necessary dummy value for no-op
      [bl, in, rel] = getInput(obj, x);
      nIn = length(in);

      if obj.phase == "Releasing"
        if length(obj.qR) > 1 || obj.useSingleElementBatch
          y.outR.E = obj.qR;   % output a batch object
        else
          y.outR = obj.qR;     % output a single object
        end
        y.nq = length(obj.q);
      else
        if ~isempty(rel)
          M = getMatchingEntities(obj, rel);
          if isempty(M)
            y.noRel = true;
          else
            y.noRel = false;
          end
        end

        if obj.phaseQ == "QueuingFree"
          if bl
            y.nq = length(obj.q) + nIn;
          else
            y.out = obj.q(1);
            y.nq = length(obj.q) + nIn - 1;
          end
        else
          y.nq = length(obj.q) + nIn;
        end
      end

      if obj.debug
        fprintf("%-8s lambda\n", obj.name)
        showInput(obj, x)
        showOutput(obj, y)
      end
    end

    function t = ta(obj)
      if obj.phase == "Releasing"
        t = obj.tD;
      else
        switch obj.phaseQ
          case {"EmptyFree", "EmptyBlocked", "QueuingBlocked"}
            t = [Inf,0];
          case "QueuingFree"
            t = obj.tD;
        end
      end
    end

    %-------------------------------------------------------
    function [bl, in, rel] = getInput(obj, x)
      % returns input values of bl, in and rel
      % value = [], if there is no input at a port
      if isfield(x, "bl")
        bl = x.bl;
      else
        bl = [];
      end

      if isfield(x, "in")
        in = x.in;
      else
        in = [];
      end

      if isfield(x, "rel") && ~isempty(x.rel)
        names = fieldnames(x.rel);
        rel{1} = names{1};
        rel{2} = x.rel.(rel{1});
      else
        rel = [];
      end
    end

    function M = getMatchingEntities(obj, rel)
      % returns indices of matching entities
      if isempty(obj.q)
        M = [];
        return
      end

      if rel{1} == "queuePosition_"
        if rel{2} > 0
          M = rel{2};
        else
          M = length(obj.q) + 1 + rel{2};
        end
        if length(obj.q) < M || M <= 0
          M = [];
        end
      else
        M = find([obj.q(:).(rel{1})] == rel{2});
      end
    end

    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%s phaseQ=%s\n", obj.phase, obj.phaseQ)
      fprintf("  q=%s\n", getDescription(obj.q));
      fprintf("  qR=%s\n", getDescription(obj.qR));
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
