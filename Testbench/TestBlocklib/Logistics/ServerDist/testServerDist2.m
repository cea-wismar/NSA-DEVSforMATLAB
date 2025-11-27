function out = testServerDist2(showPlot)
  % tests with triangular distribution
  if nargin == 0
    showPlot = false;
  end

  model = "ServerDist2_Model";
  tEnd = 6;
  seed = 2;

  model_generator(model);
  out = model_simulator(model, tEnd, "seed", seed);

  if showPlot
    width = 400;
    height = 600;
    fig = figure("name", "testServerDist2", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    t = tiledlayout(3,1);
    t.TileSpacing = "compact";
    t.Padding = "compact";

    nexttile()
    stem(out.gen.t,out.gen.y); grid on;
    xlim([0 tEnd]);
    title("Generator out");
    xlabel("t")

    nexttile()
    stem(out.que.t,out.que.y); grid on;
    xlim([0 tEnd]);
    title("Queue out");
    xlabel("t")

    nexttile()
    stem(out.srv.t,out.srv.y); grid on;
    xlim([0 tEnd]);
    title("Server out");
    xlabel("t")
  end
end