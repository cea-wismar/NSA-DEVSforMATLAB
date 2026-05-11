function out = testSingleHold(showPlot)
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  model = "SingleHold_Model";
  tEnd = 17;

  model_generator(model);
  out = model_simulator(model, tEnd);

  if showPlot
    fig = figure("name", "testSingleHold", "NumberTitle", "off");
    width = 600;
    height = 500;
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    t = tiledlayout(2,1);
    t.TileSpacing = "compact";
    t.Padding = "compact";

    nexttile(1)
    stem(out.inE.t,out.inE.y); grid("on");
    hold("on");
    stairs(out.inCond.t,out.inCond.y, "*-");
    hold("off");
    xlim([0 tEnd]);
    %ylim([-0.1 1.1]);
    xlabel("t");
    legend("inE", "inCond", "Location", "northwest");
   
    nexttile(2)
    stem(out.outE.t,out.outE.y); grid on;
    hold("on");
    stem(out.outDrop.t,out.outDrop.y); grid on;
    hold("off");
    xlim([0 tEnd]);
    %ylim([0 3.5]);
    xlabel("t");
    legend("outE", "outDrop", "Location", "northwest");
  end
end