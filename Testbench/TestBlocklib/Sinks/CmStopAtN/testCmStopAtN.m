function out = testCmStopAtN(showPlot)
  if nargin == 0
    showPlot = false;
  end

  % makes and runs model and plots results
  model = "CmStopAtN_Model";
  tEnd = 8;
  model_generator(model);
  out = model_simulator(model, tEnd);

  if showPlot
    fig = figure("name", "testCmStopAtN", "NumberTitle", "off");
    width = 500;
    height = 300;
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    stem(out.gen.t, out.gen.y);
    grid("on");
    xlim([0, tEnd])
    ylim([0, 10])
    title("out") ;
    xlabel("t")
  end
end
