function out = testNot(showPlot)
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  tEnd = 10;
  model_generator("Not_Model");
  out = model_simulator("Not_Model", tEnd);

  if showPlot
    width = 600;
    height = 400;
    fig = figure("name", "testNot", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    t = tiledlayout(2,1);
    t.TileSpacing = "compact";
    t.Padding = "compact";

    nexttile
    stairs(out.genOut.t,out.genOut.y, "*-");
    grid("on");
    xlabel("simulation time");
    ylabel("out");
    title("Gen");
    xlim([0, tEnd])
    ylim([-0.1, 1.1])

    nexttile
    stairs(out.notOut.t,out.notOut.y, "*-");
    grid("on");
    xlabel("simulation time");
    ylabel("out");
    title("Not");
    xlim([0, tEnd])
    ylim([-0.1, 1.1])
  end
end