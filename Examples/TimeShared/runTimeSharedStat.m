function outN = runTimeSharedStat(showPlot)
  % makes and runs model and plots results
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  model = "timeSharedStat";
  tEnd = 1400;
  rng(3);     % reset random stream only once at the beginning!

  % set parameters
  tW = 25;
  tS = 0.8;
  q = 0.1;
  tSwap = 0.015;
  NJ = 1000;

  oldpath = addpath(genpath("atomics"));
  load_system(model);
  hBlock = getSimulinkBlockHandle("timeSharedStat/Terminals", true);
  set_param(hBlock, "tW", string(tW))
  set_param(hBlock, "tS", string(tS))
  hBlock2 = getSimulinkBlockHandle("timeSharedStat/CPU", true);
  set_param(hBlock2, "q", string(q))
  set_param(hBlock2, "tSwap", string(tSwap))
  hBlock3 = getSimulinkBlockHandle("timeSharedStat/NJ", true);
  set_param(hBlock3, "value", string(NJ))

  if showPlot
    fprintf("\n  N     tR_avg    nQ_avg   util     runtime\n")
    fprintf("=============================================\n")
  end

  out = [];
  for N = 10:10:80
    set_param(hBlock, "N", string(N))
    model_generator(model);
    tic;
    outN = model_simulator(model, tEnd);  % don't set seed option!
    out = [out; outN];
    tCPU = toc;
    if showPlot
      showStatistics(outN, N, tCPU)
    end
  end

  path(oldpath);
end

%---------------------------------------------------------------------------
function showStatistics(out, N, tCPU)
  fprintf("  %2d   %6.3f    %6.3f    %5.3f    %5.2f\n", N, out.tRMean.y(end), ...
    out.nQMean.y(end), out.util.y(end), tCPU)
end