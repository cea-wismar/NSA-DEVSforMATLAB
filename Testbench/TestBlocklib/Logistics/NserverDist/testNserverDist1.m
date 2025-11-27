function out = testNserverDist1(showPlot)
  % input numbers
  if nargin == 0
    showPlot = false;
  end

  tEnd = 20;
  seed = 42;

	load_system("NserverDist1_Model");
	model_generator("NserverDist1_Model");
	out = model_simulator("NserverDist1_Model", tEnd, "seed", seed);

  if showPlot
    width = 600;
    height = 600;
    fig = figure("name", "testNserverDist1", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)
    t = tiledlayout(2,2);
    t.TileSpacing = "compact";
    t.Padding = "compact";

    nexttile()
    stem(out.genOut.t,[out.genOut.y]); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("id");
    title("Generator");

    nexttile()
    stairs(out.nqOut.t,out.nqOut.y); grid on;
    hold("on");plot(out.nqOut.t,out.nqOut.y, "*");hold("off");
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("nq");
    title("Queue");

    nexttile()
    stairs(out.nsOut.t,out.nsOut.y); grid on;
    hold("on");plot(out.nsOut.t,out.nsOut.y, "*");hold("off");
    xlim([0 tEnd]);
    ylim([-0.1, 3.5])
    xlabel("simulation time");
    ylabel("ns");
    title("Server");
  
    nexttile()
    stem(out.srvOut.t,out.srvOut.y); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("id");
    title("Server");
  end
end