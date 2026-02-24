function out = testNotI3e(showPlot)
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  tEnd = 14;
  model_generator("NotI3e_Model");
  out = model_simulator("NotI3e_Model", tEnd);

  if showPlot
    width = 600;
    height = 400;
    fig = figure("name", "testNotI3e", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    t = tiledlayout(2,1);
    t.TileSpacing = "compact";
    t.Padding = "compact";

    nexttile
    plot_ieee1164(out.gen1Out.t, out.gen1Out.y);
    grid("on");
    xlabel("simulation time");
    ylabel("out");
    title("Gen1");
    xlim([0, tEnd])

    nexttile
    plot_ieee1164(out.notOut.t, out.notOut.y);
    grid("on");
    xlabel("simulation time");
    ylabel("out");
    title("Not");
    xlim([0, tEnd])
  end
end