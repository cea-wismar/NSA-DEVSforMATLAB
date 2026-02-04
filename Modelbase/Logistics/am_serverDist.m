classdef am_serverDist < handle
%% Description
%  processes one entity in time tS, where tS is a random number with given
%  distribution
%% Ports
%  inputs: 
%    in   incoming entities
%  outputs: 
%    out      outgoing entities
%    working  true if processing entity
%    n        current number of entities in server
%% States
%  s:      idle|busy
%  E:      id of processed entity
%  tSNext: next service time
%  sig:    next switching time
%% System Parameters
%  name:     object name
%  distName: distribution name (Constant/Exponential/Triangular)
%  distPara: distribution parameters
%            Constant     [a]      constant value
%            Exponential  [a]      mean value
%            Triangular   [a,m,b]  [min, most, max]
%  tau:      input delay
%  debug:    model debug level

  properties
    s
    E
    sig
    tSNext
    name
    distName
    distPara
    tau
    debug
    epsilon
  end
  
  methods
    function obj = am_serverDist(name, distName, distPara, tau, debug)
      obj.s = "idle";
      obj.E = [];
      obj.sig = [inf,0];
      obj.name = name;
      obj.distName = distName;
      obj.distPara = distPara;
      obj.debug = debug;
      obj.epsilon = get_epsilon();
      obj.tau = tau;

      % Check input para compliance
      try
        switch obj.distName
          case {"Constant", "Exponential"}
            assert(isscalar(obj.distPara));
          case "Triangular"
            assert(numel(obj.distPara)==3);
          otherwise
            error("Name of distribution is unknown.")
        end
      catch
        error(obj.name + ": Distribution parameters do not match.")
      end

      obj.tSNext = distributionFcn(obj.distName, obj.distPara);
    end
    
    function delta(obj,e,x)
      if obj.debug
        fprintf("%-8s entering delta\n", obj.name)
        showState(obj);
      end      

      if isempty(x)      % internal event
        obj.s = "idle";
        obj.E = [];
        obj.sig = [inf,0];
      elseif (e(1) < obj.sig(1) - obj.epsilon)   % external event
        switch obj.s 
          case "idle"
            if ~isempty(x.in)
              obj.s = "busy";
              obj.E = x.in;
              obj.sig = [obj.tSNext,0];
              obj.tSNext = distributionFcn(obj.distName, obj.distPara);
            end
          case "busy"
            if ~isempty(x.in)
              fprintf("delta: in phase %s in %s - dropping input %2d\n", ...
                 obj.s, obj.name, x.in)
               obj.sig = obj.sig - e;   % adjust waiting time
            end
          otherwise
            fprintf("delta: wrong phase %s in %s\n", obj.s, obj.name);
        end
      else   % confluent event
        if ~isempty(x.in)
         obj.s = "busy";     % unnecessary, is busy anyhow
         obj.E = x.in;
         obj.sig = [obj.tSNext,0];
         obj.tSNext = distributionFcn(obj.distName, obj.distPara);
        end
      end

      if obj.debug
        fprintf("%-8s leaving delta\n", obj.name)
        showState(obj);
      end      
    end
    
    function y = lambda(obj,e,x)
      y = [];     % necessary dummy value for no-op
      if isempty(x)      % internal event
        y.out = obj.E;
        y.working = false;
        y.n = 0;
      elseif (e(1) < obj.sig(1))   % external event
        if obj.s == "idle"
          %y.out = [];   % leads to errors!
          y.working = true;
          y.n = 1;
        end
      else   % confluent event
        y.out = obj.E;
        y.working = true;
        y.n = 1;
      end
      
      if obj.debug
        fprintf("%-8s lambda\n", obj.name)
        showInput(obj, x)
        showOutput(obj, y)
      end
    end
    
    function t = ta(obj)
      t = obj.sig;
    end
    
    %-------------------------------------------------------
    function showState(obj)
      % debug function, prints current state
      fprintf("  phase=%4s E=[ %s] sig=%4.2f\n",...
        obj.s, getDescription(obj.E), obj.sig(1))
    end

    function showInput(obj, x)
      % debug function, prints current input
      fprintf("  in: ");
      if isfield(x, "in")
        fprintf("[ %s]", getDescription(x.in));
      end
    end

    function showOutput(obj, y)
      % debug function, prints current output
      fprintf(", out: ")
      if isfield(y, "out")
        fprintf("[ %s] ", getDescription(y.out));
      end
      if isfield(y, "working")
        fprintf("working=%1d ", str2double(y.working));
      end
      if isfield(y, "n")
        fprintf("n=%1d", y.n);
      end
      fprintf("\n")
    end 
  end
end
