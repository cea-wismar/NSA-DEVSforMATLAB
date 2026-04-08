function out = testReleaseQueue1(testcase, showPlot)
  % ReleaseQueue releasing via attribute + unbatch
  if ~exist("testcase", "var")
    testcase = 1;
  end
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  model = "ReleaseQueue1_Model";

  switch testcase
    case 1   % -> 3 entities with value 1
      seed = 3;
      tEnd = 6.5;
    case 2   % -> 1 entity with value 1
      seed = 11;
      tEnd = 10;
    case 3   % -> 0 entities with value 1
      seed = 13;
      tEnd = 10;
    otherwise
      seed = 3;
      tEnd = 6.5;
  end
  rng(seed);

  model_generator(model);
  out = model_simulator(model, tEnd);

  if showPlot
    width = 800;
    height = 500;
    fig = figure("name", "testReleaseQueue1", "NumberTitle", "off");
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

    nexttile(5)
    stairs(out.nq.t, out.nq.y, "-*"); grid on;
    xlim([0 tEnd]);
    title("Queue nq");
    xlabel("t")

    if isfield(out, "outQ")
      nexttile(4)
      stem(out.outQ.t,[out.outQ.y.value]); grid on;
      xlim([0 tEnd]);
      title("Queue outR (value)");
      xlabel("t")

      nexttile(6)
      stem(out.term.t, out.term.y); grid on;
      xlim([0 tEnd]);
      title("Terminator n");
      xlabel("t")
    end
  end
end