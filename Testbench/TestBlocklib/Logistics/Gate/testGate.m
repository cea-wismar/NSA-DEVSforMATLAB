function [out] = testGate(showPlot)
  if nargin == 0
    showPlot = false;
  end

  tEnd = 19;
  model_generator("Gate_Model");
  out = model_simulator("Gate_Model", tEnd);

  if showPlot
    fig = figure("name", "testGate", "NumberTitle", "off");
    width = 500;
    height = 600;
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    t = tiledlayout(3,1);
    t.TileSpacing = "compact";
    t.Padding = "compact";

    nexttile(1);
    stairs(out.bingenOut.t, out.bingenOut.y, "-*");
    xlim([0 tEnd]);
    ylim([-0.1 1.1]);
    xlabel("t");
    ylabel("open");

    nexttile(2);
    stem(out.genOut.t,out.genOut.y); grid on;
    xlim([0 tEnd]);
    ylim([0 21]);
    xlabel("t");
    ylabel("gen out");

    nexttile(3);
    stem(out.gateOut.t,out.gateOut.y); grid on;
    xlim([0 tEnd]);
    ylim([0 21]);
    xlabel("t");
    ylabel("gate out");
  end

end