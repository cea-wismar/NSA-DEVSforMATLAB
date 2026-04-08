function out = testGetTime(showPlot)
  if nargin == 0
    showPlot = false;
  end

  model = "GetTime_Model";
  tEnd = 6;
  model_generator(model);
  out = model_simulator(model, tEnd);

  if showPlot
    fig = figure("name", "testGetTime", "NumberTitle", "off");
    width = 500;
    height = 600;
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    t = tiledlayout(2,1);
    t.TileSpacing = "compact";
    t.Padding = "compact";

    nexttile(1)
    stairs(out.trigger.t,out.trigger.y, "*-"); grid on;
    xlim([0 tEnd]);
    ylim([-0.1 1.1]);
    xlabel("simulation time");
    ylabel("trigger");

    nexttile(2)
    stem(out.gen.t,out.gen.y); grid on;
    xlim([0 tEnd]);
    ylim([0 6]);
    xlabel("simulation time");
    ylabel("out");
  end
end