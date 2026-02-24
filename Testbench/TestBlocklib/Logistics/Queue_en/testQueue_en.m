function out = testQueue_en(showPlot)
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  tEnd = 200;
  model_generator("Queue_en_Model");
  out = model_simulator("Queue_en_Model", tEnd);

  if showPlot
    width = 800;
    height = 900;
    fig = figure("name", "testQueue_en", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    t = tiledlayout(5,1);
    t.TileSpacing = "compact";
    t.Padding = "compact";

    nexttile
    stem(out.genOut.t,out.genOut.y); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("out");
    title("Generator");

    nexttile
    stairs(out.bingenOut.t, out.bingenOut.y);
    xlim([0 tEnd]);
    ylim([-0.1, 1.1]);
    xlabel("simulation time");
    ylabel("enable");

    nexttile
    stairs(out.bufferNQ.t,out.bufferNQ.y); grid on;
    xlim([0 tEnd]);
    ylim([0 20]);
    xlabel("simulation time");
    ylabel("NQ");

    nexttile
    stairs(out.srvnOut.t,out.srvnOut.y); grid on;
    hold("on");plot(out.srvnOut.t,out.srvnOut.y, "*");hold("off");
    xlim([0 tEnd]);
    ylim([-0.1, 1.1])
    xlabel("simulation time");
    ylabel("n");
    title("Server");

    nexttile
    stem(out.srvOut.t,out.srvOut.y); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("out");
    title("Server");
  end
end