function out = testEnabledGenerator3(showPlot)
  % check handling of intermediate enable=true inputs
  if nargin == 0
    showPlot = false;
  end

  tEnd = 4;
  model = "EnabledGenerator3_Model";
  model_generator(model);
  out = model_simulator(model, tEnd);

  if showPlot
    width = 600;
    height = 400;
    fig = figure("name", "testEnabledGenerator3", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    t = tiledlayout(2,1);
    t.TileSpacing = "compact";
    t.Padding = "compact";

    nexttile
    stairs(out.vecOut.t,out.vecOut.y, "*-"); grid on;
    xlim([0 tEnd]);
    ylim([-0.1,1.1])
    xlabel("t");
    ylabel("vecOut");

    nexttile
    stem(out.genOut.t,out.genOut.y); grid on;
    xlim([0 tEnd]);
    ylim([0 5]);
    xlabel("t");
    ylabel("gen out");
  end
end
