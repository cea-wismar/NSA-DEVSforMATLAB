function out = testEpsDelay(showPlot)
  if nargin == 0
    showPlot = false;
  end

  tEnd = 5;
  model = "EpsDelay_Model";
  model_generator(model);
  global mu 
  mu = 0.1;
  out = model_simulator(model, tEnd);
  mu = 0.0;

  if showPlot
    figure("Position",[1 1 450 500]);
    subplot(2,1,1)
    stem(out.genOut.t,out.genOut.y);
    grid("on");
    xlim([0, tEnd])
    xlabel("simulation time");
    ylabel("out");
    title("EpsDelay in");

    subplot(2,1,2)
    stem(out.EpsDelayOut.t,out.EpsDelayOut.y);
    grid("on");
    xlim([0, tEnd])
    xlabel("simulation time");
    ylabel("out");
    title("EpsDelay out");
  end

end
