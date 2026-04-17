function out = testProductionLineS(showPlot)
  if ~exist("showPlot", "var")
    showPlot = false;
  end

  oldpwd = cd("../../../Examples/BigExampleS");
  load_system("ProductionLineLib_AM");
  load_system("ProductionLineLib_CM");
  
  out = runProductionLineS(showPlot);
  
  close_system("ProductionLineLib_AM");
  close_system("ProductionLineLib_CM");
  cd(oldpwd)
end
