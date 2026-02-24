function [out] = testEnabledGenerator(showPlot)
  if nargin == 0
    showPlot = false;
  end

  global simout
  global epsilon
  global DEBUGLEVEL
  global mu
  mu = 0.0;
  simout = [];
  DEBUGLEVEL = 0;           % simulator debug level
  epsilon = 1e-6;

  tG = 0.9;
  n0 = 2;
  nG = 12;
  tEnable = [3.0, 6.0, 12, 14, 100];
  tEnd = 19;
  debug = false;               % model debug level
  tD = [0,2];
  tau = [0,1];
  tauOut = [0,3];

  N1 = coordinator('N1');

  Generator = devs(am_enabledgenerator("Generator", tG, n0, nG, tD, tau, debug));
  Bingenerator = devs(am_bingenerator("Bingenerator", true, tEnable, tau, debug));
  Terminator = devs(am_terminator("Terminator", tau, debug));
  Genout = devs(am_toworkspace("Genout", "genOut", 0, "vector", tauOut, 0));
  Bingenout = devs(am_toworkspace("Bingenout", "bingenOut", 0, "vector", tauOut, 0));

  N1.add_model(Generator);
  N1.add_model(Bingenerator);
  N1.add_model(Terminator);
  N1.add_model(Genout);
  N1.add_model(Bingenout);

  N1.add_coupling("Bingenerator","out","Generator","enable");
  N1.add_coupling("Generator","out","Terminator","in");
  N1.add_coupling("Bingenerator","out","Bingenout","in");
  N1.add_coupling("Generator","out","Genout","in");

  root = rootcoordinator("root",0,tEnd,N1,0,0);
  root.sim();
  out = simout;

  if showPlot
    width = 600;
    height = 400;
    fig = figure("name", "testEnabledGenerator", "NumberTitle", "off");
    pos = get(fig, "Position");
    pos(3:4) = [width, height];
    set(fig, "Position", pos)

    t = tiledlayout(2,1);
    t.TileSpacing = "compact";
    t.Padding = "compact";

    nexttile
    stairs(out.bingenOut.t,out.bingenOut.y, "*-");
    xlim([0 tEnd]);
    ylim([-0.1,1.1])
    xlabel("t");
    ylabel("enable");

    nexttile
    stem(out.genOut.t,out.genOut.y); grid on;
    xlim([0 tEnd]);
    ylim([0 15]);
    xlabel("t");
    ylabel("gen out");
  end

end