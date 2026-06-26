function out = model_simulator(model, tEnd, varargin)
  % runs a model
  % assumes previous call of model_generator
  % parameters
  %   model       name of model to run
  %   tEnd        end time of simulation
  % options
  %   "clearFlag"   true (default) -> out directory is removed
  %   "displayFlag" true -> show timestamps
  %   "seed"        seed for rng()

  options.clearFlag = true;
  options.displayFlag = false;
  options.seed = NaN;

  for i=1:2:length(varargin)
  	if isfield(options, varargin{i})
  		options.(varargin{i}) = varargin{i+1};
  	else
  		warning("input %d is not a valid option", i);
  	end
  end

  global simout

  if ~isnan(options.seed)
  	rng(options.seed);
  end

  simout = [];     % delete values from previous runs

  addpath(model);
  sCmd = sprintf('build_%s("model")', model);
  N0 = eval(sCmd);
  rmpath(model);

  root = rootcoordinator("root", 0, tEnd, N0, 0, options.displayFlag);
  root.sim();

  out = simout;

  if options.clearFlag
    rmdir(model, "s")
  end
