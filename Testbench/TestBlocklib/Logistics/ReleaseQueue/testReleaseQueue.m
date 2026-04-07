function out = testReleaseQueue(showPlot)
  % ReleaseQueue releasing via attribute
  if nargin == 0
    showPlot = false;
  end

  model = "ReleaseQueue_Model";
  tEnd = 6.5;
  seed = 3;
  rng(seed);

  model_generator(model);
  out = model_simulator(model, tEnd);

  if showPlot
    width = 800;
    height = 500;
    fig = figure("name", "testReleaseQueue", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    t = tiledlayout(3,2);
    t.TileSpacing = "compact";
    t.Padding = "compact";

    nexttile(1)
    stem(out.in.t,[out.in.y.value]); grid on;
    xlim([0 tEnd]);
    title("Queue in (value)");
    xlabel("t")

    nexttile(3)
    stem(out.out.t,[out.out.y.value]); grid on;
    xlim([0 tEnd]);
    title("Queue out (value)");
    xlabel("t")

    nexttile(2)
    stem(out.rel.t,[out.rel.y.value]); grid on;
    xlim([0 tEnd]);
    title("Release in (value)");
    xlabel("t")

    nexttile(4)
    val = [out.outR.y.E.value];
    stem(out.outR.t, val(1)); grid on;
    xlim([0 tEnd]);
    title("Queue outR (value)");
    xlabel("t")

    nexttile(5)
    stairs(out.nq.t, out.nq.y, "-*"); grid on;
    xlim([0 tEnd]);
    title("Queue nq");
    xlabel("t")

    nexttile(6)
    stem(out.term.t, out.term.y); grid on;
    xlim([0 tEnd]);
    title("Terminator n");
    xlabel("t")
  end
end