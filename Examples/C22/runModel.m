function out = runModel(nr, showPlot)
  % makes and runs model and plots results
  % nr = 1/2, two variants of the model
  if ~exist("nr", "var")
    nr = 1;
  end
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  switch nr
    case 1
      model = "c22FixFifoA";
    case 2
      model = "c22FixFifoB";
    otherwise
      model = "c22FixFifoA";
  end

  tEnd = 140;

  model_generator(model);
  out = model_simulator(model, tEnd);

  if showPlot    % gather results and plot them
    allXacts = [out.output.t', out.output.y'];
    qAll = [out.SUM_N.t', out.SUM_N.y'];
    qWaits = [0,0];  % dummy
    plotStatBench(qAll, allXacts, qWaits, 1)
  end
