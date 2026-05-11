function out = testAnd2(showPlot)
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  model = "And2_Model";
  tEnd = 12;

  model_generator(model);
  out = model_simulator(model, tEnd);

  if showPlot
    width = 500;
    height = 600;
    fig = figure("name", "testAnd2", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    t = tiledlayout(4,1);
    t.TileSpacing = "compact";
    t.Padding = "compact";

    nexttile
    stairs(out.gen1Out.t,out.gen1Out.y, "*-");
    title("Generator 1");
    xlim([0, tEnd])
    ylim([-0.1,1.1])

    nexttile
    stairs(out.gen2Out.t,out.gen2Out.y, "*-");
    title("Generator 2");
    xlim([0, tEnd])
    ylim([-0.1,1.1])

   nexttile
    stairs(out.andOut.t,out.andOut.y, "*-");
    xlim([0, tEnd])
    ylim([-0.1,1.1])
    title("And2");

    nexttile
    stem(out.nOut.t, out.nOut.y);
    title("Terminator");
    xlim([0, tEnd])
  end
end
