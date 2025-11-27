function out = testServerDist1(showPlot)
  % tests with exponential distribution
  if nargin == 0
    showPlot = false;
  end

  tEnd = 15;

	load_system("ServerDist1_Model");
	model_generator("ServerDist1_Model");
	out = model_simulator("ServerDist1_Model", tEnd, "seed", 3);

  if showPlot
    width = 600;
    height = 600;
    fig = figure("name", "testServerDist1", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)
    t = tiledlayout(2,2);
    t.TileSpacing = "compact";
    t.Padding = "compact";

    nexttile()
    stem(out.genOut.t,out.genOut.y); grid on;
    xlim([0 tEnd]);
    xlabel("time");
    ylabel("id");
    title("Generator");

    nexttile()
    stairs(out.nqOut.t,out.nqOut.y); grid on;
    hold("on");plot(out.nqOut.t,out.nqOut.y, "*");hold("off");
    xlim([0 tEnd]);
    ylim([-0.1, 3.1])
    xlabel("time");
    ylabel("nq");
    title("Queue");

    nexttile()
    stem(out.srvOut.t,[out.srvOut.y]); grid on;
    xlim([0 tEnd]);
    xlabel("time");
    ylabel("id");
    title("Server");

    nexttile()
    stairs(out.nsOut.t,out.nsOut.y); grid on;
    hold("on");plot(out.nsOut.t,out.nsOut.y, "*");hold("off");
    xlim([0 tEnd]);
    ylim([-0.1, 1.1])
    xlabel("time");
    ylabel("ns");
    title("Server");
  end
end