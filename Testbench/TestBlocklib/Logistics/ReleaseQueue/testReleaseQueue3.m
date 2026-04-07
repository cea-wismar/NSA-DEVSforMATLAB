function out = testReleaseQueue3(showPlot)
  % checking state change of phaseQ after releasing
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  model = "ReleaseQueue3_Model";
  tEnd = 10;
  seed = 3;
  rng(seed);

  model_generator(model);
  out = model_simulator(model, tEnd);

  if showPlot
    width = 800;
    height = 500;
    fig = figure("name", "testReleaseQueue3", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    t = tiledlayout(2,2);
    t.TileSpacing = "compact";
    t.Padding = "compact";

    nexttile(1)
    stem(out.in.t, out.in.y); grid on;
    xlim([0 tEnd]);
    title("Queue in (value)");
    xlabel("t")

    nexttile(3)
    stem(out.out.t, out.out.y); grid on;
    xlim([0 tEnd]);
    title("Queue out (value)");
    xlabel("t")

    nexttile(2)
    stem(out.rel.t,[out.rel.y.queuePosition_]); grid on;
    xlim([0 tEnd]);
    title("Release in (value)");
    xlabel("t")

    if isfield(out, "outR")
      nexttile(4)
      stem(out.outR.t, out.outR.y); grid on;
      xlim([0 tEnd]);
      title("Queue outR (value)");
      xlabel("t")
    end
  end
end