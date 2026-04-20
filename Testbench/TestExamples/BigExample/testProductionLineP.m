function out = testProductionLineP(showPlot)
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  oldpwd = cd("../../../Examples/BigExample");
  load_system("StdLib");
  load_system("ProductionLinePLib");

  out = runProductionLine(3, showPlot);

  close_system("StdLib");
  close_system("ProductionLinePLib");
  cd(oldpwd)
end
