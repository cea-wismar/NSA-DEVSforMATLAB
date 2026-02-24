classdef am_gate < handle
  %% Description
  %  Sends input entities to output, if gate is open,
  %  otherwise entities "disappear" !
  %% Ports
  %  inputs:
  %    in     incoming entities
  %    open   state of gate
  %  outputs:
  %    out    outgoing entities
  %% States
  %  s: running
  %  isOpen: basic state of gate (true = open, false = closed)
  %% System Parameters
  %  name:     object name
  %  isOpen0:  initial value of isOpen 
  %  debug:    flag to enable debug information
  %  tau:      input delay

  properties
    s
    isOpen
    name
    isOpen0
    debug
    tau
  end

  methods
    function obj = am_gate(name, isOpen0, tau, debug)
      obj.s = "running";
      obj.isOpen0 = isOpen0;
      obj.isOpen = isOpen0;
      obj.name = name;
      obj.debug = debug;
      obj.tau = tau;
    end

    function delta(obj,e,x)
      if ~isempty(x) && isfield(x, "open")
        obj.isOpen = x.open;
      end
    end

    function y = lambda(obj,e,x)
      open = obj.isOpen;
      if ~isempty(x) && isfield(x, "open")
        open = x.open;
      end

      if open && ~isempty(x) && isfield(x, "in")
        y.out = x.in;
      else
        y = [];
      end
    end

    function t = ta(obj)
      t = [inf, 0];
    end

  end
end
