function out = testServerDist(testcase,showPlot)
  % tests with constant distribution
  if ~exist('testcase','var')
    testcase = 1;
  end
  if ~exist('showPlot','var')
    showPlot = 0;
  end

  switch testcase
    case 1   % generator too fast -> loosing entities
      tG = 1.0;
    case 2   % correct behaviour
      tG = 2.0;
    otherwise
      tG = 2.0;
  end

  tEnd = 8;

  load_system("ServerDist_Model");
  set_param("ServerDist_Model/am_generator", "tG", string(tG));

  model_generator("ServerDist_Model");
  out = model_simulator("ServerDist_Model", tEnd);

  if showPlot
    width = 400;
    height = 600;
    fig = figure("name", "testServerDist", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)
    t = tiledlayout(3,1);
    t.TileSpacing = "compact";
    t.Padding = "compact";

    nexttile()
    stem(out.genOut.t,out.genOut.y); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("out");
    title("Generator");

    nexttile()
    stairs(out.srvnOut.t,out.srvnOut.y); grid on;
    hold("on");plot(out.srvnOut.t,out.srvnOut.y, "*");hold("off");
    xlim([0 tEnd]);
    ylim([-0.1, 1.1])
    xlabel("simulation time");
    ylabel("n");
    title("Server");

    nexttile()
    stem(out.srvOut.t,out.srvOut.y); grid on;
    xlim([0 tEnd]);
    xlabel("simulation time");
    ylabel("out");
    title("Server");
  end
end
