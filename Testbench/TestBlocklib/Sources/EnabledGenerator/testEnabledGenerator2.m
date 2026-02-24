function out = testEnabledGenerator2(showPlot)
  % check handling of empty input
  if nargin == 0
    showPlot = false;
  end

  tEnd = 5;
  model = "EnabledGenerator2_Model";
  model_generator(model);
  out = model_simulator(model, tEnd);

  if showPlot
    width = 600;
    height = 600;
    fig = figure("name", "testEnabledGenerator2", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    t = tiledlayout(3,1);
    t.TileSpacing = "compact";
    t.Padding = "compact";

    nexttile
    stairs(out.vecOut.t,out.vecOut.y, "*-"); grid on;
    xlim([0 tEnd]);
    ylim([-0.1,1.1])
    xlabel("t");
    ylabel("vecOut");

    nexttile
    stairs(out.notOut.t,out.notOut.y, "*-"); grid on;
    xlim([0 tEnd]);
    ylim([-0.1,1.1])
    xlabel("t");
    ylabel("enable");

    nexttile
    stem(out.genOut.t,out.genOut.y); grid on;
    xlim([0 tEnd]);
    ylim([0 5]);
    xlabel("t");
    ylabel("gen out");
  end
end
