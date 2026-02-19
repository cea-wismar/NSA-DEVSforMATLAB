function out = testNor3(showPlot)
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  model = "Nor3_Model";
  tEnd = 14;

  model_generator(model);
  out = model_simulator(model, tEnd);

  if showPlot
    width = 600;
    height = 800;
    fig = figure("name", "testNor3", "NumberTitle", "off");
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
    stairs(out.gen3Out.t,out.gen3Out.y, "*-");
    title("Generator 3");
    xlim([0, tEnd])
    ylim([-0.1,1.1])

    nexttile
    stairs(out.norOut.t,out.norOut.y, "*-");
    xlim([0, tEnd])
    ylim([-0.1,1.1])
    title("Nor3");
  end
end
