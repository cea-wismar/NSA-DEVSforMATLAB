function out = testFixFifo(nr, showPlot)
  if ~exist("nr", "var")
    nr = 1;
  end
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  oldpwd = cd("../../../Examples/C22");
  out = runModel(nr, showPlot);
  cd(oldpwd)
end
