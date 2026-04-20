function out = runProductionLineS(showPlot)
  % makes and runs model and plots results
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  model = "productionLineS";
  tEnd = 8000;
 
  oldpath = addpath("atomics");
  model_generator(model);
  out = model_simulator(model, tEnd);
  if showPlot
    plotResults(out, tEnd, model)
  end
  path(oldpath);
end

%---------------------------------------------------------------------------
function plotResults(out, tEnd, model)
  width = 800;
  height = 900;
  fig = figure("name", model, "NumberTitle", "off");
  pos = get(fig, "Position");
  pos(3:4) = [width, height];
  set(fig, "Position", pos)

  t = tiledlayout(3,3);
  t.TileSpacing = "compact";
  t.Padding = "compact";

  nexttile(1)
  stairs(out.loadPeak.t, out.loadPeak.y)
  title("loadPeak");
  xlabel("t [s]");
  xlim([0 tEnd]);

  nexttile(2)
  stairs(out.pcStock.t, out.pcStock.y)
  title("pcStock");
  xlabel("t [s]");
  xlim([0 tEnd]);

  nexttile(3)
  stairs(out.pcUtil.t, out.pcUtil.y)
  title("pcUtil");
  xlabel("t [s]");
  xlim([0 tEnd]);

  nexttile(4)
  stairs(out.thrput.t, out.thrput.y)
  title("thrput");
  xlabel("t [s]");
  xlim([0 tEnd]);

  nexttile(5)
  stairs(out.eSpec.t, out.eSpec.y)
  title("eSpec");
  xlabel("t [s]");
  xlim([0 tEnd]);

  nexttile(6)
  stairs(out.procTime.t, out.procTime.y)
  title("procTime");
  xlabel("t [s]");
  xlim([0 tEnd]);

  nexttile(7, [1,2])
  stem(out.eOut.t, out.eOut.y)
  title("eOut");
  xlabel("t [s]");
  xlim([0 tEnd]);
end
