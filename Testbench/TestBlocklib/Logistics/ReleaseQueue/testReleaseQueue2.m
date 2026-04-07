function out = testReleaseQueue2(testcase, showPlot)
  % ReleaseQueue releasing via position
  if ~exist("testcase", "var")
    testcase = 1;
  end
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  switch testcase
    case 1   % positive position 
      yVec = [3,42];
    case 2   % negative position 
      yVec = [-3,42];
    case 3   % too large positive
      yVec = [8,42];
    otherwise
      yVec = [3,42];
  end

  model = "ReleaseQueue2_Model";
  tEnd = 10;

  load_system(model);
  set_param(model + "/am_vectorgen", "yvec", mat2str(yVec));

  model_generator(model);
  out = model_simulator(model, tEnd);

  if showPlot
    width = 800;
    height = 500;
    fig = figure("name", "testReleaseQueue2", "NumberTitle", "off");
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